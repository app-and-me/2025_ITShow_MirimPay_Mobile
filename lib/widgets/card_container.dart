import 'package:flutter/material.dart';
import 'package:mirim_pay/app/data/models/card_model.dart' as card_model;
import 'package:mirim_pay/util/style/colors.dart';
import 'package:mirim_pay/util/style/typography.dart';

class CardContainer extends StatelessWidget {
  final card_model.Card card;

  const CardContainer({
    super.key,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);
    
    return Container(
      width: 219,
      height: 348,
      decoration: ShapeDecoration(
        color: colors.gray300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              card.cardNickname,
              style: Typo.bodyMd(context, color: colors.gray700),
            ),
            const SizedBox(height: 8),
            Text(
              '${card.id}',
              style: Typo.bodySm(context, color: colors.gray500),
            ),
          ],
        ),
      ),
    );
  }
}
