import 'package:get/get.dart';
import 'package:mirim_pay/app/data/models/card_model.dart';
import 'package:mirim_pay/app/data/repositories/card_repository.dart';
import 'package:mirim_pay/app/data/repositories/alert_repository.dart';
import 'package:mirim_pay/util/constants/app_constants.dart';

class PayPageViewModel extends GetxController {
  final CardRepository _cardRepository = Get.find<CardRepository>();
  final AlertRepository _alertRepository = Get.find<AlertRepository>();
  
  final RxBool isLoading = false.obs;
  final RxList<Card> cards = <Card>[].obs;
  final RxInt currentCardIndex = 0.obs;
  final RxBool showAddCard = false.obs;
  final RxBool hasNewNotification = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadCards();
    loadNotificationStatus();
  }

  @override
  void onReady() {
    super.onReady();
    loadNotificationStatus();
  }

  Future<void> loadCards() async {
    isLoading.value = true;
    try {
      final userCards = await _cardRepository.getUserCards();
      cards.value = userCards;
      if (userCards.isEmpty) {
        showAddCard.value = true;
      } else {
        showAddCard.value = false;
        if (currentCardIndex.value >= userCards.length) {
          currentCardIndex.value = userCards.length - 1;
        }
      }
    } catch (e) {
      Get.snackbar(AppStrings.error, '카드 정보를 불러오는데 실패했습니다.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadNotificationStatus() async {
    try {
      final unreadCount = await _alertRepository.getUnreadCount();
      hasNewNotification.value = unreadCount > 0;
    } catch (_) {
    }
  }

  Future<void> refreshCards() async {
    await loadCards();
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
    Get.toNamed(AppRoutes.cardWrite);
  }

  Card? get currentCard => cards.isNotEmpty && !showAddCard.value 
      ? cards[currentCardIndex.value] 
      : null;

  bool get canNavigateLeft => cards.length > 1 && currentCardIndex.value > 0;
  bool get canNavigateRight => cards.isNotEmpty && !showAddCard.value;
  bool get isPaymentDisabled => cards.isEmpty || showAddCard.value;

  String get alertIconPathDark => hasNewNotification.value 
      ? 'assets/icons/alert_exist_dark.svg' 
      : 'assets/icons/alert_default_dark.svg';

  String get alertIconPathLight => hasNewNotification.value 
      ? 'assets/icons/alert_exist_light.svg' 
      : 'assets/icons/alert_default_light.svg';
}
