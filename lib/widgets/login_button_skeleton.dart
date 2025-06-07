import 'package:flutter/material.dart';
import 'package:mirim_pay/util/style/colors.dart';

class LoginButtonSkeleton extends StatelessWidget {
  const LoginButtonSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 85),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 74, vertical: 16),
        decoration: BoxDecoration(
          color: colors.gray200,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colors.gray300, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                color: colors.gray300,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              height: 16,
              width: 120,
              decoration: BoxDecoration(
                color: colors.gray300,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
