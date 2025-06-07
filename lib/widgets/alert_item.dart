import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../util/style/colors.dart';
import '../util/style/typography.dart';
import '../pages/alert/models/alert_model.dart';

class AlertItemWidget extends StatelessWidget {
  final AlertModel alert;
  final VoidCallback? onTap;

  const AlertItemWidget({
    super.key,
    required this.alert,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        color: colors.gray50,
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/notification.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                alert.type == AlertType.inStock 
                  ? colors.yellow 
                  : const Color(0xFFFF2007), 
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    alert.typeDisplayText,
                    style: Typo.bodySm(
                      context, 
                      color: colors.gray700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    alert.message,
                    style: Typo.bodyMd(context, color: colors.gray800),
                  ),
                ],
              ),
            ),
            Text(
              alert.formattedDate,
              style: Typo.caption(context, color: colors.gray500),
            ),
          ],
        ),
      ),
    );
  }
}
