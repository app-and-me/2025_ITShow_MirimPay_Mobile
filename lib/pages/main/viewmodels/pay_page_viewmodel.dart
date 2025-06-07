import 'package:get/get.dart';
import 'package:mirim_pay/app/data/models/card_model.dart';
import 'package:mirim_pay/app/data/repositories/card_repository.dart';
import 'package:mirim_pay/util/constants/app_constants.dart';

class PayPageViewModel extends GetxController {
  final CardRepository _cardRepository = Get.find<CardRepository>();
  
  final RxBool isLoading = false.obs;
  final RxList<Card> cards = <Card>[].obs;
  final RxInt currentCardIndex = 0.obs;
  final RxBool showAddCard = false.obs;
  final RxBool hasNewNotification = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadCards();
  }

  Future<void> loadCards() async {
    isLoading.value = true;
    try {
      final userCards = await _cardRepository.getUserCards();
      cards.value = userCards;
      if (userCards.isEmpty) {
        showAddCard.value = true;
      }
    } catch (e) {
      Get.snackbar(AppStrings.error, '카드 정보를 불러오는데 실패했습니다.');
    } finally {
      isLoading.value = false;
    }
  }

  void nextCard() {
    if (currentCardIndex.value < cards.length - 1) {
      currentCardIndex.value++;
      showAddCard.value = false;
    } else {
      showAddCard.value = true;
    }
  }

  void prevCard() {
    if (showAddCard.value) {
      currentCardIndex.value = cards.length - 1;
    } else if (currentCardIndex.value > 0) {
      currentCardIndex.value--;
    }
    showAddCard.value = false;
  }

  void navigateToAlert() {
    Get.toNamed(AppRoutes.alert);
  }

  void navigateToAddCard() {
    Get.toNamed('/card_write');
  }

  Card? get currentCard => cards.isNotEmpty && !showAddCard.value 
      ? cards[currentCardIndex.value] 
      : null;

  bool get canNavigateLeft => cards.length > 1 && currentCardIndex.value > 0;
  bool get canNavigateRight => cards.isNotEmpty && !showAddCard.value;
  bool get isPaymentDisabled => cards.isEmpty || showAddCard.value;

  String get alertIconPath => hasNewNotification.value 
      ? 'assets/icons/alert_exist.svg' 
      : 'assets/icons/alert_default.svg';
}
