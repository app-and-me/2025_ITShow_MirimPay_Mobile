import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirim_pay/app/data/models/card_model.dart' as card_model;
import 'package:mirim_pay/app/data/repositories/card_repository.dart';
import 'package:mirim_pay/util/style/colors.dart';
import 'package:mirim_pay/util/style/typography.dart';

class CardInfoViewModel extends GetxController {
  final CardRepository _repository = Get.find<CardRepository>();
  
  final RxBool isLoading = false.obs;
  final RxList<card_model.Card> cards = <card_model.Card>[].obs;
  final RxBool isDeleting = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    loadCards();
  }
  
  Future<void> loadCards() async {
    isLoading.value = true;
    try {
      final cardData = await _repository.getUserCards();
      cards.value = cardData;
    } catch (e) {
      Get.snackbar('오류', '카드 정보를 불러오는데 실패했습니다.');
    } finally {
      isLoading.value = false;
    }
  }
  
  void showCardDetails(card_model.Card card) {
    showModalBottomSheet(
      context: Get.context!,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildCardDetailsModal(context, card),
    );
  }
  
  Widget _buildCardDetailsModal(BuildContext context, card_model.Card card) {
    final colors = ThemeColors.of(context);
    
    return Container(
      decoration: BoxDecoration(
        color: colors.gray50,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      padding: const EdgeInsets.all(28),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  width: 100,
                  height: 63,
                  decoration: BoxDecoration(
                    color: colors.gray300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        card.name,
                        style: Typo.bodyMd(context, color: colors.gray900),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        card.number,
                        style: Typo.bodySm(context, color: colors.gray700)
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
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
            const SizedBox(height: 28),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    setMainCard(card.id);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      '결제카드 설정',
                      style: Typo.bodyMd(context, color: colors.gray800),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    _showDeleteConfirmation(card);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      '카드 삭제',
                      style: Typo.bodyMd(context, color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  void _showDeleteConfirmation(card_model.Card card) {
    final colors = ThemeColors.of(Get.context!);
    
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: 311,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: colors.gray50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '카드를 삭제하시겠어요?',
                style: Typo.headlineSub(Get.context!, color: colors.gray900),
              ),
              const SizedBox(height: 12),
              Text(
                '카드를 삭제하면 다시 카드를 사용할 수 없어요.',
                style: Typo.bodySm(Get.context!, color: colors.gray700)
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Text(
                        '취소',
                        style: Typo.bodySm(Get.context!, color: colors.gray500)
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      deleteCard(card.id);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Text(
                        '삭제하기',
                        style: Typo.bodySm(Get.context!, color: colors.red)
                          .copyWith(fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Future<void> deleteCard(int cardId) async {
    isDeleting.value = true;
    try {
      await _repository.removeCard(cardId);
      cards.removeWhere((card) => card.id == cardId);
      Get.snackbar('완료', '카드가 삭제되었습니다.');
    } catch (e) {
      Get.snackbar('오류', '카드 삭제에 실패했습니다.');
    } finally {
      isDeleting.value = false;
    }
  }

  Future<void> setMainCard(int cardId) async {
    isLoading.value = true;
    try {
      await _repository.setMainCard(cardId);
      for (var card in cards) {
        card.isMainCard = (card.id == cardId);
      }
      Get.snackbar('완료', '메인 카드가 설정되었습니다.');
    } catch (e) {
      Get.snackbar('오류', '메인 카드 설정에 실패했습니다.');
    } finally {
      isLoading.value = false;
    }
  }
  
  void goBack() {
    Get.back();
  }
}
