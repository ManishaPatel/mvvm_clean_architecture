import 'package:get/get.dart';
import 'package:mvvm_clean_architecture/core/routes/routes_name.dart';
import 'package:mvvm_clean_architecture/presentation/pages/department_page.dart';
import 'package:mvvm_clean_architecture/presentation/pages/employee_page.dart';
import 'package:mvvm_clean_architecture/presentation/pages/home_page.dart';
import 'package:mvvm_clean_architecture/presentation/pages/login_page.dart';
import 'package:mvvm_clean_architecture/presentation/pages/splash_page.dart';
import '../../presentation/pages/dashboard.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
            name: RoutesName.splashScreen,
            page: () => SplashPage(),
            transitionDuration: Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade),

        GetPage(
          name: RoutesName.login,
          page: () => LoginPage(),
          // transitionDuration: Duration(milliseconds: 250),
          // transition: Transition.leftToRightWithFade
        ),

        GetPage(
            name: RoutesName.dashboard,
            page: () => Dashboard(),
            participatesInRootNavigator: true,
            transitionDuration: Duration(milliseconds: 250),
            transition: Transition.rightToLeftWithFade,
            children: [
              GetPage(
                  name: RoutesName.dashboardHome,
                  page: () => HomePage(),
                  transitionDuration: Duration(milliseconds: 250),
                  transition: Transition.downToUp),
              GetPage(
                  name: RoutesName.dashboardEmployee,
                  page: () => EmployeePage(),
                  transitionDuration: Duration(milliseconds: 250),
                  transition: Transition.downToUp),
              GetPage(
                  name: RoutesName.dashboardDepartment,
                  page: () =>  DepartmentPage(),
                  transitionDuration: Duration(milliseconds: 250),
                  transition: Transition.downToUp),
            ]),
      ];
}
