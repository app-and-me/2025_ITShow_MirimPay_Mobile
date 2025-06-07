import 'package:flutter/material.dart';
import 'package:mirim_pay/util/style/colors.dart';
import 'package:mirim_pay/util/style/typography.dart';

class CategoryTab extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback? onTap;

  const CategoryTab({
    super.key,
    required this.text,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: Typo.headlineSub(
                context,
                color: isSelected ? colors.primary : colors.gray400,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 35,
              height: 1,
              child: Container(
                color: isSelected ? colors.primary : Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
