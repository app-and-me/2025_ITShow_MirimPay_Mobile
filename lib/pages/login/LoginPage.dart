import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:mirim_oauth_flutter/mirim_oauth_flutter.dart';
import 'package:mirim_pay/pages/Main.dart';
import 'package:mirim_pay/util/service/AuthService.dart';
import 'package:mirim_pay/util/style/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    ThemeColors colors = ThemeColors.of(context);

    return Scaffold(
      backgroundColor: colors.gray50,
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await auth.logIn();

            if (auth.isLoggedIn) {
              print(auth.currentUser.toString());
              Get.offAllNamed('/');
            } else {
              Get.snackbar(
                'Login Failed',
                'Please try again.',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red,
                colorText: colors.gray900,
              );
            }
            
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}