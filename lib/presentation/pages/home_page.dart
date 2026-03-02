import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:mvvm_clean_architecture/presentation/widgets/user_item_scree.dart';
import '../../core/app_color.dart';
import '../../core/routes/routes_name.dart';
import '../../core/text_style.dart';
import '../../core/utils.dart';
import '../controllers/internet_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  final InternetController internetController = Get.find<InternetController>();
  static const double kMaxContentWidth = 800.0;

  @override
  Widget build(BuildContext context) {
    final isMobile = Utils().checkPlatform();

    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage("assets/images/signup.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black,
                ],
              ),
            ),
            child: Scaffold(
              extendBodyBehindAppBar: internetController.isInternetViewVisible.value ? true : false,
              backgroundColor: Colors.transparent,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(
                  internetController.isInternetViewVisible.value ? 170 : 140,
                ),
                child: Obx(
                      () => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (internetController.isInternetViewVisible.value)
                        SafeArea(
                            bottom: false,
                            top: true,
                            child: Center(
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(maxWidth: 800),
                                  child: Utils().internetNotAvailableView(false, internetController),
                                ))),

                      SafeArea(
                        bottom: false,
                        top: true,
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 800),
                            child: appBar(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              resizeToAvoidBottomInset: false,
              body: LayoutBuilder(
                builder: (context, constraints) {
                  final double contentWidth =
                  constraints.maxWidth > kMaxContentWidth
                      ? kMaxContentWidth
                      : double.infinity;
                  return Center(
                    child: Container(
                      width: contentWidth,
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return NotificationItemScreen();
                                },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.asset(
                                      'assets/images/icn_clear.svg'),
                                ),
                                InkWell(
                                  splashColor: Colors.white24,
                                  highlightColor: Colors.white10,
                                  onTap: () {

                                  },
                                  child: Text(
                                    'clear_all',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )));
  }

  Widget appBar() {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: AppBar(
        backgroundColor: AppColor.transparent,
        automaticallyImplyLeading: true,
        leading: ClipOval(
          child: Material(
            color: AppColor.transparent,
            child: InkWell(
              splashColor: Colors.white24,
              highlightColor: Colors.white10,
              onTap: () {
                Get.offNamed(RoutesName.dashboard);
              },
              child: Padding(
                padding: EdgeInsets.only(top: 0, bottom: 4, left: 4, right: 4),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
        title: Center(
          child: Padding(
            padding: EdgeInsets.only(right: 32),
            child: Text(
              'users',
              style: TextStyles.appBarTitle(context),
            ),
          ),
        ),
        actions: [
          Visibility(
            visible: false,
            child: Icon(Icons.notifications, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
