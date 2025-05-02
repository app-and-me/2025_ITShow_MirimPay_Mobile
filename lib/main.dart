import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/route_manager.dart';
import 'package:mirim_oauth_flutter/mirim_oauth_flutter.dart';
import 'package:mirim_pay/pages/Main.dart';
import 'package:mirim_pay/pages/alert/AlertPage.dart';
import 'package:mirim_pay/pages/login/LoginPage.dart';
import 'package:mirim_pay/pages/main/ContactUsPage.dart';
import 'package:mirim_pay/pages/main/MePage.dart';
import 'package:mirim_pay/pages/main/PayPage.dart';
import 'package:mirim_pay/pages/main/ProductPage.dart';
import 'package:mirim_pay/util/service/AuthService.dart';
import 'package:mirim_pay/util/style/colors.dart';
import 'package:mirim_pay/util/style/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/config/.env");
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});
  
  @override
  // ignore: library_private_types_in_public_api
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late bool isLoggedIn = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    bool loginStatus = await auth.checkIsLoggedIn();
    setState(() {
      isLoggedIn = loginStatus;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeColors colors = ThemeColors.of(context);
    
    if (isLoading) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              color: colors.gray100,
            ),
          ),
        ),
        theme: initThemeData(brightness: Brightness.light),
        darkTheme: initThemeData(brightness: Brightness.dark),
        themeMode: ThemeMode.system,
      );
    }
    
    return GetMaterialApp(
      getPages: [
        GetPage(name: '/', page: () => const MainPage()),
        GetPage(name: '/product', page: () => const ProductPage()),
        GetPage(name: '/contact-us', page: () => const ContactUsPage()),
        GetPage(name: '/me', page: () => const MePage()),
        GetPage(name: '/pay', page: () => const PayPage()),
        GetPage(name: '/alert', page: () => const AlertPage()),
        GetPage(name: '/login', page: () => const LoginPage()),
      ],
      initialRoute: isLoggedIn ? '/' : '/login',
      debugShowCheckedModeBanner: false,
      theme: initThemeData(brightness: Brightness.light),
      darkTheme: initThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.system,
    );
  }
}

