import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvvm_clean_architecture/presentation/controllers/internet_controller.dart';
import 'package:mvvm_clean_architecture/presentation/pages/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/routes/routes.dart';
import 'core/routes/routes_name.dart';
import 'presentation/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  Get.put(prefs);
  InternetController internetController = Get.put(InternetController());
  Get.put(internetController);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Employee Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
        ),
      ),
      initialRoute: RoutesName.splashScreen,
      getPages: AppRoutes.appRoutes(),
      home: FutureBuilder<bool>(
        future: SharedPreferences.getInstance().then((prefs) => prefs.getBool('isLoggedIn') ?? false),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          return snapshot.data == true ? const Dashboard() : const LoginPage();
        },
      ),
    );
  }
}
