import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mirim_pay/util/style/colors.dart';
import 'package:mirim_pay/util/style/typography.dart';

class DateFilterHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const DateFilterHeader({
    super.key,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: Typo.bodyMd(context, color: colors.gray700),
          ),
          const SizedBox(width: 5),
          SvgPicture.asset(
            'assets/icons/arrow_down.svg',
            width: 16,
            height: 16,
            colorFilter: ColorFilter.mode(
              colors.gray700,
              BlendMode.srcIn,
            ),
          ),
        ],
      ),
    );
  }
}
