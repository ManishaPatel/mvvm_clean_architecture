import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class InternetController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  RxInt connectionType = 0.obs;      // 0 = none, 1 = wifi, 2 = mobile
  RxBool isInternetViewVisible = false.obs;
  RxBool isInternetAvailable = false.obs;
  RxBool userClosed = false.obs;

  late StreamSubscription<List<ConnectivityResult>> _streamSubscription;
  Timer? _autoShowTimer;

  @override
  void onInit() {
    super.onInit();
    _getConnectionType();

    /// FIXED (new connectivity_plus API)
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> resultList) {
          if (resultList.isNotEmpty) {
            _updateConnectionType(resultList.first);
          }
        });
  }

  Future<void> _getConnectionType() async {
    try {
      final resultList = await _connectivity.checkConnectivity();
      _updateConnectionType(resultList.first);
    } on PlatformException catch (e) {
      print("Error checking connectivity: $e");
      connectionType.value = 0;
    }
  }

  Future<void> _updateConnectionType(ConnectivityResult result) async {
    print("📡 Connectivity changed: $result");

    switch (result) {
      case ConnectivityResult.wifi:
        connectionType.value = 1;
        break;
      case ConnectivityResult.mobile:
        connectionType.value = 2;
        break;
      case ConnectivityResult.none:
        connectionType.value = 0;
        isInternetAvailable.value = false;
        print("❌ No network");
        return;
      default:
        connectionType.value = 0;
    }

    /// Real internet check
    isInternetAvailable.value = await _checkRealInternet();

    print("➡️ Final Internet State → "
        "connectionType: ${connectionType.value}, "
        "isInternetAvailable: ${isInternetAvailable.value}");
  }

  Future<bool> _checkRealInternet() async {
    try {
      final lookup = await InternetAddress.lookup('google.com');
      return lookup.isNotEmpty && lookup.first.rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  void closeBannerManually() {
    userClosed.value = true;
    isInternetViewVisible.value = false;

    _autoShowTimer?.cancel();
    _autoShowTimer = Timer(const Duration(seconds: 10), () async {
      bool stillOffline = !await _checkRealInternet();

      if (stillOffline) {
        userClosed.value = false;
        isInternetViewVisible.value = true;
      }
    });
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
    _autoShowTimer?.cancel();
    super.onClose();
  }
}
