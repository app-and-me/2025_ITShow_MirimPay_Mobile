import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mirim_pay/pages/main/viewmodels/pay_page_viewmodel.dart';
import 'package:mirim_pay/widgets/card_section.dart';
import 'package:mirim_pay/widgets/card_skeleton.dart';
import 'package:mirim_pay/widgets/qr_pay_button.dart';
import 'package:mirim_pay/util/style/typography.dart';
import 'package:mirim_pay/util/style/colors.dart';

class PayPage extends GetView<PayPageViewModel> {
  const PayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);

    return Scaffold(
      backgroundColor: colors.gray50,
      appBar: AppBar(
        title: Text(
          '결제',
          style: Typo.headlineLg(context, color: colors.gray900),
        ),
        centerTitle: false,
        actions: [
          Obx(() => IconButton(
            icon: SvgPicture.asset(
              context.isDarkMode ? controller.alertIconPathDark : controller.alertIconPathLight,
            ),
            onPressed: controller.navigateToAlert,
          )),
        ],
        backgroundColor: colors.gray50,
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        child: Obx(() {
          if (controller.isLoading.value) {
            return Column(
              children: [
                const CardSkeleton(),
                const SizedBox(height: 24),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 12),
                    decoration: BoxDecoration(
                      color: colors.gray200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: colors.gray300,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 50,
                          height: 16,
                          decoration: BoxDecoration(
                            color: colors.gray300,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          return Column(
            children: [
              CardSection(
                cards: controller.cards,
                currentIndex: controller.currentCardIndex.value,
                showAddCard: controller.showAddCard.value,
                onNextCard: controller.nextCard,
                onPrevCard: controller.prevCard,
                onAddCard: controller.navigateToAddCard,
              ),
              const SizedBox(height: 24),
              if (controller.currentCard != null)
                QrPayButton(
                  isDisabled: controller.isPaymentDisabled,
                  card: controller.currentCard!,
                ),
            ],
          );
        }),
      ),
    );
  }
}

