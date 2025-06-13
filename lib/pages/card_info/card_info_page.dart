import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mirim_pay/pages/card_info/viewmodels/card_info_viewmodel.dart';
import 'package:mirim_pay/util/style/colors.dart';
import 'package:mirim_pay/util/style/typography.dart';
import 'package:mirim_pay/widgets/card_info_item.dart';
import 'package:mirim_pay/widgets/card_info_skeleton.dart';

class CardInfoPage extends GetView<CardInfoViewModel> {
  const CardInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);
    
    return Scaffold(
      backgroundColor: colors.gray50,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, colors),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const CardInfoSkeleton();
                }
                
                if (controller.cards.isEmpty) {
                  return Center(
                    child: Text(
                      '등록된 카드가 없어요',
                      style: Typo.headlineSub(context, color: colors.gray700),
                    ),
                  );
                }
                
                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 4),
                  itemCount: controller.cards.length,
                  itemBuilder: (context, index) {
                    final card = controller.cards[index];
                    return CardInfoItem(card: card);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ThemeColors colors) {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 21),
      child: Row(
        children: [
          GestureDetector(
            onTap: controller.goBack,
            child: SvgPicture.asset(
              'assets/icons/arrow_left.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                colors.gray900,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            '카드 정보',
            style: Typo.headlineSub(context, color: colors.gray900),
          ),
        ],
      ),
    );
  }
}
