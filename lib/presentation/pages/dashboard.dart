import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/app_color.dart';
import '../../core/constants.dart';
import '../../core/logger.dart';
import '../../core/responsive.dart';
import '../../core/routes/routes_name.dart';
import '../../core/text_style.dart';
import '../../core/utils.dart';
import '../controllers/internet_controller.dart';
import '../widgets/dialog/yes_no_message_dialog_box.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String _selectedKey = 'home';
  bool isLogin = false;
  final InternetController internetController = Get.find<InternetController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );
    final prefs = Get.find<SharedPreferences>();
    // await prefs.setBool('isLoggedIn', false);
    // prefs.getBool(Constant.spIsLogin)?.then((value) {
    //   setState(() {
    //     isLogin = value;
    //     Constant.isLogin.value = value;
    //   });
    // });
  }

  void _onItemTapped(String key) {
    if (_selectedKey == key) {
      return;
    }

    switch (key) {
      case 'home':
        Get.rootDelegate.toNamed(
          "${RoutesName.dashboard}${RoutesName.dashboardHome}",
        );
        break;
      case 'employees':
        Get.rootDelegate.toNamed(
          "${RoutesName.dashboard}${RoutesName.dashboardEmployee}",
        );
        break;
      case 'departments':
        Get.rootDelegate.toNamed(
          "${RoutesName.dashboard}${RoutesName.dashboardDepartment}",
        );
        break;
    }
    // 2. Update state after navigation
    setState(() {
      _selectedKey = key;
      Log.info("Selected Key:: $_selectedKey");
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    // final bool isTablet = Responsive.isTablet(context); // Unused
    // final bool isDesktop = Responsive.isDesktop(context); // Unused

    return WillPopScope(
      onWillPop: () async {
        final shouldExit = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return YesNoMessageDialogBox(
              title: Constant.appName,
              textEditing: 'do_you_want_to_exit'.tr,
              yes: 'yes'.tr,
              no: 'no'.tr,
              yesCallback: () {
                Navigator.of(context).pop(true);
              },
              noCallback: () {
                Navigator.of(context).pop(false);
              },
            );
          },
        );
        if (shouldExit == true) {
          SystemNavigator.pop();
        }
        return false;
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isLargeScreen = constraints.maxWidth > 600;
          return Scaffold(
            key: _scaffoldKey,
            // FIX 1: Set to true so the body (which holds the background) starts behind the AppBar
            extendBodyBehindAppBar: true,
            backgroundColor: AppColor.transparent,
            // drawer: const CustomDrawer(),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(
                internetController.isInternetViewVisible.value ? 170 : 140,
              ),
              child: Obx(
                () => Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    internetController.isInternetViewVisible.value
                        ? Utils().internetNotAvailableView(
                            false,
                            internetController,
                          )
                        : const SizedBox.shrink(),
                    // SafeArea(
                    //   bottom: false,
                    //   top: true,
                    //   // child: appBar(isMobile ? 40 : 24),
                    // ),
                  ],
                ),
              ),
            ),
            body: isLargeScreen
                ? Row(
                    children: [
                      _buildNavigationRail(),
                      Expanded(child: _buildRouterOutlet()),
                    ],
                  )
                : _buildRouterOutlet(),
            // floatingActionButton: _buildFloatingActionButton(),
            // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: !isLargeScreen ? _buildBottomAppBar() : null,
          );
        },
      ),
    );
  }

  Widget _buildRouterOutlet() {
    return Container(
      // This Container provides the background image covering the whole screen
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue, Colors.purple],
        ),
      ),
      child: Container(
        // This Container provides the gradient overlay
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.7),
              Colors.black.withOpacity(0.5),
            ],
          ),
        ),
        // FIX 2: Wrap the router outlet with SafeArea to push the navigated content down,
        // preventing it from being obscured by the AppBar and status bar.
        child: SafeArea(
          top: true,
          bottom: true,
          child: GetRouterOutlet(
            anchorRoute: RoutesName.dashboard,
            initialRoute: "${RoutesName.dashboard}${RoutesName.dashboardHome}",
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    // Only displayed on narrow screens since bottomNavigationBar is only for narrow screens
    return Builder(
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColor.roundStart, AppColor.roundEnd],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(35),
          ),
          child: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                useRootNavigator: true,
                backgroundColor: Colors.transparent,
                builder: (context) {
                  return DraggableScrollableSheet(
                    initialChildSize: 0.75,
                    minChildSize: 0.75,
                    maxChildSize: 0.95,
                    expand: true,
                    builder: (_, scrollController) => Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      // child: FilterBottomSheet(),
                    ),
                  );
                },
              );
            },
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),
            ),
            child: const Icon(Icons.filter_alt, color: Colors.white),
          ),
        );
      },
    );
  }

  Widget _buildBottomAppBar() {
    // Removed const keyword as children are non-constant
    return BottomAppBar(
      color: Colors.black,
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          // FIX: Restoring the missing bottom navigation items
          buildNavItem('assets/images/home.svg', 'home', 'home'),
          buildNavItem('assets/images/home.svg', 'employee', 'employee'),
          buildNavItem('assets/images/home.svg', 'department', 'department'),
        ],
      ),
    );
  }

  Widget _buildNavigationRail() {
    int selectedIndex = _getSelectedIndex();
    return Theme(
      // override ink/splash/hover for this subtree only
      data: Theme.of(context).copyWith(
        splashFactory: NoSplash.splashFactory,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: NavigationRail(
          backgroundColor: Colors.black,
          indicatorColor: Colors.transparent,
          useIndicator: false,
          elevation: 5,
          selectedIconTheme: const IconThemeData(color: Colors.white),
          unselectedIconTheme: IconThemeData(color: AppColor.menuUnselected),
          labelType: NavigationRailLabelType.all,
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) {
            _onItemTapped(_getKeyFromIndex(index));
          },
          destinations: [
            NavigationRailDestination(
              icon: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: SvgPicture.asset(
                  'assets/images/home.svg',
                  height: 24,
                  width: 24,
                  colorFilter: ColorFilter.mode(
                    AppColor.menuUnselected,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              selectedIcon: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: SvgPicture.asset(
                  'assets/images/home.svg',
                  height: 24,
                  width: 24,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              label: Text(
                'home'.tr,
                style: TextStyle(
                  color: _getSelectedIndex() == 0
                      ? Colors.white
                      : Colors.white24,
                ),
              ),
            ),
            NavigationRailDestination(
              icon: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: SvgPicture.asset(
                  'assets/images/home.svg',
                  height: 24,
                  width: 24,
                  colorFilter: ColorFilter.mode(
                    AppColor.menuUnselected,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              selectedIcon: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: SvgPicture.asset(
                  'assets/images/home.svg',
                  height: 24,
                  width: 24,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              label: Text(
                'employee',
                style: TextStyle(
                  color: _getSelectedIndex() == 1
                      ? Colors.white
                      : Colors.white24,
                ),
              ),
            ),
            NavigationRailDestination(
              icon: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: SvgPicture.asset(
                  'assets/images/home.svg',
                  height: 24,
                  width: 24,
                  colorFilter: ColorFilter.mode(
                    AppColor.menuUnselected,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              selectedIcon: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: SvgPicture.asset(
                  'assets/images/home.svg',
                  height: 24,
                  width: 24,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              label: Text(
                'department',
                style: TextStyle(
                  color: _getSelectedIndex() == 2
                      ? Colors.white
                      : Colors.white24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _getSelectedIndex() {
    switch (_selectedKey) {
      case 'home':
        return 0;
      case 'employee':
        return 1;
      case 'department':
        return 2;
      default:
        return 0;
    }
  }

  String _getKeyFromIndex(int index) {
    switch (index) {
      case 0:
        return 'home';
      case 1:
        return 'employee';
      case 2:
        return 'department';
      default:
        return 'home';
    }
  }

  Widget buildNavItem(String imagePath, String label, String key) {
    return Expanded(
      child: InkWell(
        splashColor: Colors.black,
        highlightColor: Colors.black,
        onTap: () {
          _onItemTapped(key);
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                imagePath,
                height: 24,
                width: 24,
                colorFilter: ColorFilter.mode(
                  _selectedKey == key ? Colors.white : AppColor.menuUnselected,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(height: 5),
              Center(
                child: Text(
                  label,
                  style: TextStyle(
                    height: 1.5,
                    color: _selectedKey == key
                        ? Colors.white
                        : AppColor.menuUnselected,
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget appBar(double iconSize) {
    return AppBar(
      backgroundColor: AppColor.transparent,
      automaticallyImplyLeading: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 15, top: 5, bottom: 5, right: 0),
        child: ClipOval(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.white24,
              highlightColor: Colors.white10,
              onTap: () {
                if (Constant.isLogin.value) {
                  _scaffoldKey.currentState?.openDrawer();
                } else {
                  Get.toNamed(RoutesName.login);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: iconSize,
                ),
              ),
            ),
          ),
        ),
      ),
      title: Center(
        child: Text(
          getAppBarTitle(_selectedKey),
          style: TextStyles.appBarTitle(context),
        ),
      ),
      actions: [
        ClipOval(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.white24,
              highlightColor: Colors.white10,
              onTap: () {
                Log.info('Cart clicked');
                // Get.toNamed(RoutesName.cart);
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.shopping_cart, size: 24, color: Colors.white),
              ),
            ),
          ),
        ),
        ClipOval(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.white24,
              highlightColor: Colors.white10,
              onTap: () {
                Log.info('Notification clicked');
                // Get.toNamed(RoutesName.notifications);
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.notifications, size: 24, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String getAppBarTitle(String key) {
    switch (key) {
      case 'home':
        return 'home'.tr;
      case 'events':
        return 'events'.tr;
      case 'myTickets':
        return 'my_tickets'.tr;
      case 'winners':
        return 'winners'.tr;
      default:
        return 'home'.tr;
    }
  }
}
