import 'package:flutter/material.dart';
import 'skeleton_loader.dart';
import 'package:mirim_pay/util/style/colors.dart';

class CardSkeleton extends StatelessWidget {
  const CardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);

    return Container(
      width: 219,
      height: 348,
      decoration: BoxDecoration(
        color: colors.gray300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SkeletonLoader(height: 20, width: 120),
            SizedBox(height: 8),
            SkeletonLoader(height: 16, width: 80),
          ],
        ),
      ),
    );
  }
}
