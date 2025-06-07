import 'package:flutter/material.dart';
import 'package:mirim_pay/util/constants/app_constants.dart';
import 'package:mirim_pay/util/style/colors.dart';
import 'package:mirim_pay/util/style/typography.dart';

class LogoutButton extends StatelessWidget {
  final VoidCallback? onTap;

  const LogoutButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
      child: Align(
        alignment: Alignment.centerLeft,
        child: GestureDetector(
          onTap: onTap,
          child: Text(
            AppStrings.logout,
            style: Typo.bodyMd(context, color: colors.gray400).copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
