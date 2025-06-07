import 'package:get/get.dart';
import 'package:mirim_pay/app/data/models/payment_history_model.dart';
import 'package:mirim_pay/app/data/repositories/payment_history_repository.dart';

class PaymentHistoryViewModel extends GetxController {
  final PaymentHistoryRepository _repository = Get.find<PaymentHistoryRepository>();
  
  final RxBool isLoading = false.obs;
  final RxList<PaymentHistory> todayPayments = <PaymentHistory>[].obs;
  final RxList<PaymentHistory> recentPayments = <PaymentHistory>[].obs;
  
  @override
  void onInit() {
    super.onInit();
    loadPaymentHistory();
  }
  
  Future<void> loadPaymentHistory() async {
    isLoading.value = true;
    try {
      final todayData = await _repository.getTodayPayments();
      final recentData = await _repository.getRecentPayments();
      
      todayPayments.value = todayData;
      recentPayments.value = recentData;
    } catch (e) {
      Get.snackbar('오류', '결제 내역을 불러오는데 실패했습니다.');
    } finally {
      isLoading.value = false;
    }
  }
  
  void goBack() {
    Get.back();
  }
}
