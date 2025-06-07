import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/route_manager.dart';
import 'package:mirim_pay/pages/main.dart';
import 'package:mirim_pay/pages/main/bindings/main_page_binding.dart';
import 'package:mirim_pay/pages/alert/alert_page.dart';
import 'package:mirim_pay/pages/alert/bindings/alert_page_binding.dart';
import 'package:mirim_pay/pages/contactus/contactus_write_page.dart';
import 'package:mirim_pay/pages/contactus/bindings/contactus_write_page_binding.dart';
import 'package:mirim_pay/pages/login/login_page.dart';
import 'package:mirim_pay/pages/login/bindings/login_page_binding.dart';
import 'package:mirim_pay/pages/main/contactus_page.dart';
import 'package:mirim_pay/pages/main/bindings/contactus_page_binding.dart';
import 'package:mirim_pay/pages/main/me_page.dart';
import 'package:mirim_pay/pages/main/bindings/me_page_binding.dart';
import 'package:mirim_pay/pages/main/pay_page.dart';
import 'package:mirim_pay/pages/main/bindings/pay_page_binding.dart';
import 'package:mirim_pay/pages/main/product_page.dart';
import 'package:mirim_pay/pages/main/bindings/product_page_binding.dart';
import 'package:mirim_pay/pages/pay/card_write_page.dart';
import 'package:mirim_pay/pages/pay/bindings/card_write_page_binding.dart';
import 'package:mirim_pay/pages/payment_history/payment_history_page.dart';
import 'package:mirim_pay/pages/payment_history/bindings/payment_history_binding.dart';
import 'package:mirim_pay/pages/card_info/card_info_page.dart';
import 'package:mirim_pay/pages/card_info/bindings/card_info_binding.dart';
import 'package:mirim_pay/pages/face_registration/face_registration_page.dart';
import 'package:mirim_pay/pages/face_registration/bindings/face_registration_binding.dart';
import 'package:mirim_pay/util/service/auth_service.dart';
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
    try {
      final loginStatus = await auth.checkIsLoggedIn();
      setState(() {
        isLoggedIn = loginStatus;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoggedIn = false;
        isLoading = false;
      });
    }
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
        GetPage(
          name: '/', 
          page: () => const MainPage(),
          binding: MainPageBinding(),
        ),
        GetPage(
          name: '/product', 
          page: () => const ProductPage(),
          binding: ProductPageBinding(),
        ),
        GetPage(
          name: '/contact-us', 
          page: () => const ContactUsPage(),
          binding: ContactUsPageBinding(),
        ),
        GetPage(
          name: '/me', 
          page: () => const MePage(),
          binding: MePageBinding(),
        ),
        GetPage(
          name: '/pay', 
          page: () => const PayPage(),
          binding: PayPageBinding(),
        ),
        GetPage(
          name: '/alert', 
          page: () => const AlertPage(),
          binding: AlertPageBinding(),
        ),
        GetPage(
          name: '/login', 
          page: () => const LoginPage(),
          binding: LoginPageBinding(),
        ),
        GetPage(
          name: '/contact_us_write', 
          page: () => const ContactUsWritePage(),
          binding: ContactUsWritePageBinding(),
        ),
        GetPage(
          name: '/card_write', 
          page: () => const CardWritePage(),
          binding: CardWritePageBinding(),
        ),
        GetPage(
          name: '/payment-history', 
          page: () => const PaymentHistoryPage(),
          binding: PaymentHistoryBinding(),
        ),
        GetPage(
          name: '/card-info', 
          page: () => const CardInfoPage(),
          binding: CardInfoBinding(),
        ),
        GetPage(
          name: '/face-registration', 
          page: () => const FaceRegistrationPage(),
          binding: FaceRegistrationBinding(),
        ),
      ],
      initialRoute: isLoggedIn ? '/' : '/login',
      debugShowCheckedModeBanner: false,
      theme: initThemeData(brightness: Brightness.light),
      darkTheme: initThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.system,
    );
  }
}

