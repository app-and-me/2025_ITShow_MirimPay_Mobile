import 'package:flutter/material.dart';
import 'package:mirim_pay/util/style/colors.dart';
import 'package:mirim_pay/widgets/skeleton_ui.dart';

class AppLoadingSkeleton extends StatelessWidget {
  const AppLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);
    
    return Scaffold(
      backgroundColor: colors.gray50,
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SkeletonLoader(
              width: 80,
              height: 80,
              borderRadius: 40,
            ),
            SizedBox(height: 24),
            SkeletonLoader(
              width: 120,
              height: 20,
              borderRadius: 4,
            ),
            SizedBox(height: 12),
            SkeletonLoader(
              width: 100,
              height: 16,
              borderRadius: 4,
            ),
          ],
        ),
      ),
    );
  }
}
