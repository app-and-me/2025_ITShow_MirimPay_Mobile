import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/images/${card.cardNickname.replaceAll(" 카드", "")}.png',
              width: 219,
              height: 348,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Text(
              card.cardNumber,
              style: Typo.bodyMd(context, color: colors.gray900),
            ),
          ),
        ],
      ),
    );
  }
}
