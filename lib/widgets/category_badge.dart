import 'package:flutter/material.dart';
import '../util/style/colors.dart';
import '../util/style/typography.dart';

class CategoryBadge extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback? onTap;

  const CategoryBadge({
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
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? colors.primary : colors.gray50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.transparent : colors.gray300,
            width: isSelected ? 0.0 : 0.7,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: Typo.bodySm(
              context,
              color: isSelected ? colors.gray100 : colors.gray800,
            ),
          ),
        )
      ),
    );
  }
}