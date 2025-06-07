import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mirim_pay/pages/login/viewmodels/login_page_viewmodel.dart';
import 'package:mirim_pay/widgets/login_button_skeleton.dart';
import 'package:mirim_pay/util/constants/app_constants.dart';
import 'package:mirim_pay/util/style/colors.dart';
import 'package:mirim_pay/util/style/typography.dart';

class LoginPage extends GetView<LoginPageViewModel> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeColors colors = ThemeColors.of(context);

    return Scaffold(
      backgroundColor: colors.gray50,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              SvgPicture.asset('assets/icons/logo.svg'),
              const SizedBox(height: 52),
              Text(
                AppStrings.loginDescription1,
                style: Typo.headlineMd(context, color: colors.gray800),
              ),
              const SizedBox(height: 12),
              Text(
                AppStrings.loginDescription2,
                style: Typo.bodySm(context, color: colors.gray800).copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Obx(() {
                if (controller.isLoading.value) {
                  return const LoginButtonSkeleton();
                }
                
                return Padding(
                  padding: const EdgeInsets.only(bottom: 85),
                  child: ElevatedButton(
                    onPressed: controller.login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.gray50,
                      padding: const EdgeInsets.symmetric(horizontal: 74, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: colors.gray800, width: 1),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/icons/mirim_logo.png', 
                          height: 24,
                          width: 24,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          AppStrings.loginWithMirim,
                          style: Typo.bodySm(context, color: colors.gray800)
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}