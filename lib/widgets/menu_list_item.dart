import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mirim_pay/util/style/colors.dart';
import 'package:mirim_pay/util/style/typography.dart';

class MenuListItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const MenuListItem({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Typo.bodyMd(context, color: colors.gray800).copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
            SvgPicture.asset(
              'assets/icons/arrow_right.svg',
              colorFilter: ColorFilter.mode(
                colors.gray400,
                BlendMode.srcIn,
              ),
              width: 16,
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
