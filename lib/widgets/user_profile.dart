import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mirim_pay/util/style/colors.dart';
import 'package:mirim_pay/util/style/typography.dart';

class UserProfile extends StatelessWidget {
  final String userName;

  const UserProfile({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 34),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/me.svg',
            width: 36,
            height: 36,
            colorFilter: ColorFilter.mode(
              colors.gray800,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            userName,
            style: Typo.bodyMd(context, color: colors.gray800),
          ),
        ],
      ),
    );
  }
}
