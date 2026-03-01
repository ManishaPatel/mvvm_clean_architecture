// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get_core/src/get_main.dart' show Get;
// import 'package:get/get_instance/src/extension_instance.dart';
// import 'package:get/get_utils/src/extensions/internacionalization.dart';
// import 'package:permission_handler/permission_handler.dart';
// import '../custom_views/gradient_elevated_button.dart';
// import '../view_models/controller/user_view_model.dart';
// import 'app_color.dart';
//
// class PermissionHelper {
//
//   /// Request latitude & longitude with a custom dialog
//   static Future<Position?> requestLocation(BuildContext context) async {
//     // Step 2: Check permission
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       // userViewModel.loading.value == false;
//       bool proceed = await _showPermissionDialog(context,icon: Icons.location_on,
//           title: "allow_location_access".tr,
//           message: "allow_location_msg".tr);
//       if (!proceed) return null;
//       // await Future.delayed(const Duration(milliseconds: 200));
//
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return null;
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       await _showSettingsDialog(context,
//         title: "location_enable_title".tr,
//         message: "location_enable_msg".tr,
//         openSettings: Geolocator.openAppSettings,
//       );
//       return null;
//     }
//
//     // Step 1: Ensure location services are enabled
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       await _showSettingsDialog(context,
//         title: "gps_enable_title".tr,
//         message: "gps_enable_msg".tr,
//         openSettings: Geolocator.openLocationSettings,
//       );
//       return null;
//     }
//
//     // Step 3: Return current lat/lng
//     return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//   }
//
//   /// Custom dialog (like your screenshot)
//   static Future<bool> _showPermissionDialog(BuildContext context,{
//     required IconData icon,
//     required String title,
//     required String message,
//   }) async {
//     return await showDialog<bool>(
//       context: context,
//       barrierDismissible: false,
//       builder: (_) => AlertDialog(
//         backgroundColor: AppColor.white,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         title: Column(
//           children: [
//             Icon(icon, size: 48, color: AppColor.roundStart),
//             const SizedBox(height: 10), // Added const
//             Text(title),
//             const SizedBox(height: 10), // Added const
//           ],
//         ),
//
//         content: Text(
//           message,
//           style: const TextStyle(fontSize: 14), // Added const
//         ),
//         actions: [
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.only(left: 10, right: 5), // Added const
//               child: GradientElevatedButton(
//                 text: 'not_now'.tr,
//                 padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
//                 onPressed: () => Navigator.of(context, rootNavigator: true).pop(false),
//                 textColor: AppColor.black,
//                 borderRadius: 10,
//                 fontSize: 14,
//                 borderColor: AppColor.roundEnd,
//                 gradient: const LinearGradient(
//                   colors: [
//                     AppColor.white,
//                     AppColor.white
//                   ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 10), // Added const
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.only(left: 5, right: 10), // Added const
//               child: GradientElevatedButton(
//                 padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
//                 text: 'continue'.tr,
//                 fontSize: 14,
//                 onPressed: () => Navigator.of(context, rootNavigator: true).pop(true),
//                 borderRadius: 10,
//                 gradient: const LinearGradient(
//                   colors: [AppColor.roundEnd, AppColor.roundStart],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     ) ??
//         false;
//   }
//
//   /// Alert for enabling settings
//   static Future<void> _showSettingsDialog(
//       BuildContext context, {
//         required String title,
//         required String message,
//         required Future<bool> Function() openSettings,
//       }) async {
//     await showDialog(
//       context: context,
//       builder: (dialogContext) => AlertDialog(
//         backgroundColor: AppColor.white,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // Icon(Icons.location_on, size: 48, color: AppColor.roundStart),
//             // const SizedBox(height: 10),
//             Center(child: Text(title,textAlign: TextAlign.center)),
//             const SizedBox(height: 10), // Added const
//           ],
//         ),
//
//         content: Text(
//           message,
//           style: const TextStyle(fontSize: 14), // Added const
//         ),
//         actions: [
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.only(left: 10, right: 5), // Added const
//               child: GradientElevatedButton(
//                 text: 'cancel'.tr,
//                 padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
//                 onPressed: () => Navigator.of(dialogContext, rootNavigator: true).pop(),
//                 textColor: AppColor.black,
//                 borderRadius: 10,
//                 fontSize: 14,
//                 borderColor: AppColor.roundEnd,
//                 gradient: const LinearGradient(
//                   colors: [
//                     AppColor.white,
//                     AppColor.white
//                   ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 10), // Added const
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.only(left: 5, right: 10), // Added const
//               child: GradientElevatedButton(
//                 padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
//                 text: 'open_settings'.tr,
//                 fontSize: 14,
//                 onPressed: () async {
//                   // Navigator.pop(context);
//                   await openSettings();
//                   Navigator.of(dialogContext, rootNavigator: true).pop();
//                 },
//                 borderRadius: 10,
//                 gradient: const LinearGradient(
//                   colors: [AppColor.roundEnd, AppColor.roundStart],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   /// Request Notification Permission
//   static Future<bool> requestNotificationIfNeeded(BuildContext context) async {
//     try {
//       final deviceInfo = DeviceInfoPlugin();
//
//       // Detect platform safely
//       if (Theme.of(context).platform == TargetPlatform.android) {
//         final androidInfo = await deviceInfo.androidInfo;
//         final sdkInt = androidInfo.version.sdkInt ?? 0;
//         final isAndroid13OrAbove = sdkInt >= 33;
//
//         if (!isAndroid13OrAbove) {
//           // No runtime notification permission before Android 13
//           return true;
//         }
//       } else if (Theme.of(context).platform == TargetPlatform.iOS) {
//         // iOS handles notification permission differently
//         var status = await Permission.notification.status;
//         if (status.isDenied) {
//           bool proceed = await _showPermissionDialog(
//             context,
//             icon: Icons.notifications,
//             title: "notification_permission_title".tr,
//             message: "notification_permission_msg".tr,
//           );
//           if (!proceed) return false;
//
//           status = await Permission.notification.request();
//           return status.isGranted;
//         }
//         return status.isGranted;
//       } else {
//         debugPrint("Notification permission not required on desktop/web");
//         return true;
//       }
//
//       // Android-specific permission handling
//       var status = await Permission.notification.status;
//       if (status.isDenied) {
//         bool proceed = await _showPermissionDialog(context,
//           icon: Icons.notifications,
//           title: "notification_permission_title".tr,
//           message: "notification_permission_msg".tr,
//         );
//
//         if (!proceed) return false;
//
//         status = await Permission.notification.request();
//         if (status.isDenied) return false;
//       }
//
//       if (status.isPermanentlyDenied) {
//         await _showSettingsDialog(
//           context,
//           title: "notification_setting_title".tr,
//           message: "Notification_setting_msg".tr,
//           openSettings: openAppSettings,
//         );
//         return false;
//       }
//
//       return status.isGranted;
//     } catch (e) {
//       debugPrint("Notification permission error: $e");
//       return true; // Fallback to true to avoid blocking desktop/web
//     }
//   }
// }
