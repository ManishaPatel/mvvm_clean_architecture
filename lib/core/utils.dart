import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../presentation/controllers/internet_controller.dart';
import '../presentation/widgets/dialog/message_dialog.dart';
import 'app_color.dart';
import 'constants.dart';

class Utils {
  static void showToast(String message, {BuildContext? context}) {
    if (kIsWeb) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } else if (Platform.isAndroid || Platform.isIOS) {
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
      );
    } else {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      } else {
        debugPrint("Toast: $message");
      }
    }
  }

  Future<void> userNotLoginDialog(BuildContext context){
    return Future.microtask(() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return MessageDialog(
            title: Constant.appName,
            message: "please_login_first_to_access_this_feature".tr,
            okCallback: () {
              Navigator.of(context).pop();
            },
          );
        },
      );
    });
  }

  Future<bool> checkInternetNoContext() async {
    final InternetController internetController = Get.find<InternetController>();

    if (internetController.connectionType == 0) {
      Future.delayed(Duration.zero, () {
        Get.dialog(
          MessageDialog(
            okCallback: () {
              Get.back();
            },
          ),
          barrierDismissible: false,
        );
      });
      return false;
    }
    return true;
  }

  validateString(String object) {
    bool flag = false;
    if (object != "null" && object != "(null)" && object.isNotEmpty) {
      flag = true;
    }
    return flag;
  }

  Color getRandomColor(){
    return AppColor.ticketColors[Random().nextInt(AppColor.ticketColors.length)];
  }

  Color getTrendingColor(){
    return AppColor.trendingColors[Random().nextInt(AppColor.trendingColors.length)];
  }


  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static snackBar(String title, String message) {
    Get.snackbar(title, message);
  }

  // getVersionName() async {
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   String version = packageInfo.version;
  //   return version;
  // }
  //
  // Future<void> deleteFile(File file) async {
  //   try {
  //     if (await file.exists()) {
  //       await file.delete();
  //     }
  //   } catch (e) {
  //     // Error in getting access to the file.
  //   }
  // }
  //
  // static Future<String> createFolder(String folder) async {
  //   final dir = Directory((Platform.isAndroid
  //       ? await getExternalStorageDirectory() //FOR ANDROID
  //       : await getApplicationSupportDirectory() //FOR IOS
  //   )!.path + '/$folder');
  //   var status = await Permission.storage.status;
  //   if (!status.isGranted) {
  //     await Permission.storage.request();
  //   }
  //   if ((await dir.exists())) {
  //     return dir.path;
  //   } else {
  //     dir.create();
  //     return dir.path;
  //   }
  // }

  static bool validateEmail(String value) {
    RegExp regex = RegExp(r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (value.trim().isEmpty || !regex.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

  Route createRoute(Widget destination) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => destination,
      transitionDuration: const Duration(seconds: 1),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.easeInOutQuart;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  Widget internetNotAvailableView(bool isMobile, InternetController internetController){
    final bool isMobile = Utils().checkPlatform();

    return Container(
      height: 80,
      color: Colors.red,
      padding: EdgeInsets.only(left: 8, right: 8, bottom: 8, top: isMobile ? 25 : 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 8),
          Icon(Icons.wifi_off, color: Colors.white),
          SizedBox(width: 8),
          Expanded(
            child: Center(
              child: Text(internetController.connectionType.value == 0 ? "internet_not_available".tr : "socket_disconnected".tr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isMobile ? 14 : 18,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
          ClipOval(
            child: Material(
              color: Colors.transparent,
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                  splashColor: Colors.white24,
                  highlightColor: Colors.white10,
                  onTap: () => internetController.closeBannerManually(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.close, color: Colors.white),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  bool checkPlatform() {
    if (Platform.isAndroid) {
      print("Running on Android");
      return true;
    } else if (Platform.isIOS) {
      print("Running on iOS");
      return true;
    } else if (Platform.isWindows) {
      print("Running on Windows");
      return false;
    } else if (Platform.isMacOS) {
      print("Running on macOS");
      return false;
    } else if (Platform.isLinux) {
      print("Running on Linux");
      return false;
    } else {
      print("Unknown Platform");
      return false;
    }
  }
}
