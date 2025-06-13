import 'package:flutter/material.dart';
import 'package:mirim_pay/util/style/colors.dart';
import 'package:mirim_pay/widgets/skeleton_ui.dart';

class PaymentHistorySkeletonItem extends StatelessWidget {
  const PaymentHistorySkeletonItem({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);
    
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: colors.gray50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SkeletonLoader(
                  width: 30,
                  height: 16,
                  borderRadius: 4,
                ),
                SizedBox(width: 36),
                SkeletonLoader(
                  width: 80,
                  height: 16,
                  borderRadius: 4,
                ),
              ],
            ),
            SkeletonLoader(
              width: 60,
              height: 16,
              borderRadius: 4,
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentHistorySkeleton extends StatelessWidget {
  const PaymentHistorySkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);
    
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            _buildSkeletonSection(colors),
            const SizedBox(height: 37),
            _buildSkeletonSection(colors),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeletonSection(ThemeColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SkeletonLoader(
          width: 50,
          height: 16,
          borderRadius: 4,
        ),
        const SizedBox(height: 12),
        ...List.generate(3, (index) => Column(
          children: [
            const PaymentHistorySkeletonItem(),
            if (index < 2) const SizedBox(height: 0),
          ],
        )),
      ],
    );
  }
}
