import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mirim_pay/util/style/colors.dart';
import 'package:mirim_pay/util/style/typography.dart';

class AddCardButton extends StatelessWidget {
  final VoidCallback onTap;

  const AddCardButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(top: 145, left: 81, right: 80, bottom: 129),
        decoration: ShapeDecoration(
          color: colors.gray50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: colors.gray400,
              width: 1,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/add_circle.svg',
              width: 48,
              height: 48,
              colorFilter: ColorFilter.mode(
                colors.gray400,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '카드 추가',
              style: Typo.bodyMd(context, color: colors.gray400),
            ),
          ],
        ),
      ),
    );
  }
}
