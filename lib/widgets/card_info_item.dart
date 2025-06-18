import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirim_pay/app/data/models/card_model.dart' as card_model;
import 'package:mirim_pay/pages/card_info/viewmodels/card_info_viewmodel.dart';
import 'package:mirim_pay/util/style/colors.dart';
import 'package:mirim_pay/util/style/typography.dart';

class CardInfoItem extends StatelessWidget {
  final card_model.Card card;

  const CardInfoItem({
    super.key,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);
    final controller = Get.find<CardInfoViewModel>();
    
    return SizedBox(
      height: 165,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 17),
            decoration: BoxDecoration(
              color: colors.gray50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/images/${card.cardNickname.replaceAll(" 카드", "")}.png',
                          width: 74,
                          height: 117,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  card.cardNickname,
                                  style: Typo.bodyMd(context, color: colors.gray900),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  card.cardNumber,
                                  style: Typo.bodySm(context, color: colors.gray700)
                                      .copyWith(fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () => controller.showCardDetails(card),
                              child: Icon(
                                Icons.more_vert,
                                color: colors.gray400,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 21),
                        if (card.isMainCard)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE9F5EE),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '결제 카드',
                              style: Typo.caption(context, color: colors.primary),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
