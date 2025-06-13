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
import 'package:mirim_pay/pages/pin_setup/bindings/pin_confirm_binding.dart';
import 'package:mirim_pay/pages/pin_setup/bindings/pin_setup_binding.dart';
import 'package:mirim_pay/pages/pin_setup/pin_confirm_page.dart';
import 'package:mirim_pay/pages/pin_setup/pin_setup_page.dart';
import 'package:mirim_pay/util/constants/app_constants.dart';
import 'package:mirim_pay/widgets/app_loading_skeleton.dart';
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
import 'package:mirim_pay/pages/face_registration/face_camera_page.dart';
import 'package:mirim_pay/pages/face_registration/bindings/face_camera_binding.dart';
import 'package:mirim_pay/pages/face_registration/face_registration_success_page.dart';
import 'package:mirim_pay/pages/face_registration/bindings/face_registration_success_binding.dart';
import 'package:mirim_pay/pages/password_reset/password_reset_current_page.dart';
import 'package:mirim_pay/pages/password_reset/bindings/password_reset_current_binding.dart';
import 'package:mirim_pay/pages/password_reset/password_reset_new_page.dart';
import 'package:mirim_pay/pages/password_reset/bindings/password_reset_new_binding.dart';
import 'package:mirim_pay/pages/password_reset/password_reset_confirm_page.dart';
import 'package:mirim_pay/pages/password_reset/bindings/password_reset_confirm_binding.dart';
import 'package:mirim_pay/util/service/auth_service.dart';
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
    if (isLoading) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const AppLoadingSkeleton(),
        theme: initThemeData(brightness: Brightness.light),
        darkTheme: initThemeData(brightness: Brightness.dark),
        themeMode: ThemeMode.system,
      );
    }
    
    return GetMaterialApp(
      getPages: [
        GetPage(
          name: AppRoutes.main, 
          page: () => const MainPage(),
          binding: MainPageBinding(),
        ),
        GetPage(
          name: AppRoutes.product, 
          page: () => const ProductPage(),
          binding: ProductPageBinding(),
        ),
        GetPage(
          name: AppRoutes.contactUs, 
          page: () => const ContactUsPage(),
          binding: ContactUsPageBinding(),
        ),
        GetPage(
          name: AppRoutes.me, 
          page: () => const MePage(),
          binding: MePageBinding(),
        ),
        GetPage(
          name: AppRoutes.pay, 
          page: () => const PayPage(),
          binding: PayPageBinding(),
        ),
        GetPage(
          name: AppRoutes.alert, 
          page: () => const AlertPage(),
          binding: AlertPageBinding(),
        ),
        GetPage(
          name: AppRoutes.login, 
          page: () => const LoginPage(),
          binding: LoginPageBinding(),
        ),
        GetPage(
          name: AppRoutes.contactUsWrite, 
          page: () => const ContactUsWritePage(),
          binding: ContactUsWritePageBinding(),
        ),
        GetPage(
          name: AppRoutes.cardWrite, 
          page: () => const CardWritePage(),
          binding: CardWritePageBinding(),
        ),
        GetPage(
          name: AppRoutes.paymentHistory, 
          page: () => const PaymentHistoryPage(),
          binding: PaymentHistoryBinding(),
        ),
        GetPage(
          name: AppRoutes.cardInfo, 
          page: () => const CardInfoPage(),
          binding: CardInfoBinding(),
        ),
        GetPage(
          name: AppRoutes.faceRegistration, 
          page: () => const FaceRegistrationPage(),
          binding: FaceRegistrationBinding(),
        ),
        GetPage(
          name: AppRoutes.faceCamera, 
          page: () => const FaceCameraPage(),
          binding: FaceCameraBinding(),
        ),
        GetPage(
          name: AppRoutes.faceRegistrationSuccess, 
          page: () => const FaceRegistrationSuccessPage(),
          binding: FaceRegistrationSuccessBinding(),
        ),
        GetPage(
          name: AppRoutes.pinSetup, 
          page: () => const PinSetupPage(),
          binding: PinSetupBinding(),
        ),
        GetPage(
          name: AppRoutes.pinConfirm, 
          page: () => const PinConfirmPage(),
          binding: PinConfirmBinding(),
        ),
        GetPage(
          name: AppRoutes.passwordResetCurrent, 
          page: () => const PasswordResetCurrentPage(),
          binding: PasswordResetCurrentBinding(),
        ),
        GetPage(
          name: AppRoutes.passwordResetNew, 
          page: () => const PasswordResetNewPage(),
          binding: PasswordResetNewBinding(),
        ),
        GetPage(
          name: AppRoutes.passwordResetConfirm, 
          page: () => const PasswordResetConfirmPage(),
          binding: PasswordResetConfirmBinding(),
        ),
      ],
      initialRoute: isLoggedIn ? AppRoutes.main : AppRoutes.login,
      debugShowCheckedModeBanner: false,
      theme: initThemeData(brightness: Brightness.light),
      darkTheme: initThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.system,
    );
  }
}

