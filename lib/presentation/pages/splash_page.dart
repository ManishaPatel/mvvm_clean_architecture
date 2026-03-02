import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:mvvm_clean_architecture/core/routes/routes_name.dart';
import '../../core/utils.dart';
import '../controllers/internet_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>{
final InternetController internetController = Get.find<InternetController>();
@override
void initState() {
  super.initState();
  _navigateToDashboard();
}

void _navigateToDashboard() {
  Future.delayed(const Duration(seconds: 5), () {
    Get.offAllNamed(RoutesName.dashboard);
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          internetController.isInternetViewVisible.value == true ? 175 : 140,
        ),
        child: Obx(() => Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (internetController.isInternetViewVisible.value == true)
              Utils().internetNotAvailableView(Utils().checkPlatform(), internetController),
          ],
        )),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final bool isMobile = width < 600;
          final bool isTablet = width >= 600 && width < 1024;
          final bool isDesktop = width >= 1024;

          double scale(double m, double t, double d) {
            if (isDesktop) return d;
            if (isTablet) return t;
            return m;
          }

          return
            Stack(
            children: [
              // Background Image and Gradient
              Positioned.fill(
                child:
                Container(
                  decoration: BoxDecoration(gradient: LinearGradient(colors: [
                    Colors.blue.shade100,
                    Colors.blue.shade400,
                    Colors.blue.shade900,
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                )
                // child: Image.asset("assets/images/splash_elements.png", fit: BoxFit.fill),
              ),

              // /// Main centered content
              // Center(
              //   child: SingleChildScrollView(
              //     physics: const NeverScrollableScrollPhysics(),
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.end,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         SizedBox(height: constraints.maxHeight * 0.12),
              //         Image.asset(
              //           "assets/images/piitch_logo.png",
              //           width: scale(200, 250, 300),
              //           fit: BoxFit.contain,
              //         ),
              //         SizedBox(height: constraints.maxHeight * 0.18),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          );
        },
      ),
    );

  }
}
