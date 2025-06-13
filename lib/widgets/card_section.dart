import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mirim_pay/app/data/models/card_model.dart' as card_model;
import 'package:mirim_pay/widgets/add_card_button.dart';
import 'package:mirim_pay/widgets/card_container.dart';
import 'package:mirim_pay/util/style/colors.dart';

class CardSection extends StatelessWidget {
  final List<card_model.Card> cards;
  final int currentIndex;
  final bool showAddCard;
  final VoidCallback onNextCard;
  final VoidCallback onPrevCard;
  final VoidCallback onAddCard;

  const CardSection({
    super.key,
    required this.cards,
    required this.currentIndex,
    required this.showAddCard,
    required this.onNextCard,
    required this.onPrevCard,
    required this.onAddCard,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if ((cards.length > 1 && currentIndex > 0) || (showAddCard && cards.isNotEmpty))
          GestureDetector(
            onTap: onPrevCard,
            child: SvgPicture.asset(
              'assets/icons/arrow_left.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                colors.gray400,
                BlendMode.srcIn,
              ),
            ),
          )
        else
          const SizedBox(width: 24),
        const SizedBox(width: 20),
        if (cards.isEmpty || showAddCard)
          AddCardButton(onTap: onAddCard)
        else
          CardContainer(card: cards[currentIndex]),
        const SizedBox(width: 20),
        if (cards.isNotEmpty && !showAddCard)
          GestureDetector(
            onTap: onNextCard,
            child: SvgPicture.asset(
              'assets/icons/arrow_right.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                colors.gray400,
                BlendMode.srcIn,
              ),
            ),
          )
        else
          const SizedBox(width: 24),
      ],
    );
  }
}
