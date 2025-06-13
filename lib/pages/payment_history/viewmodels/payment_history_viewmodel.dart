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
      final data = await _repository.getPaymentHistory();
      
      final DateTime now = DateTime.now();
      final DateTime today = DateTime(now.year, now.month, now.day);
      final DateTime oneDayAgo = DateTime(now.year, now.month, now.day - 1);
      final DateTime twoDayAgo = oneDayAgo.subtract(const Duration(days: 1));
      final DateTime sevenDaysAgo = oneDayAgo.subtract(const Duration(days: 7));
      
      final List<PaymentHistory> todayData = [];
      final List<PaymentHistory> recentData = [];
      
      for (final payment in data) {
        final DateTime paymentDate = DateTime(
          payment.createdAt.year,
          payment.createdAt.month,
          payment.createdAt.day,
        );
        
        if (paymentDate.isAtSameMomentAs(today)) {
          todayData.add(payment);
        } else if (paymentDate.isAfter(sevenDaysAgo) && paymentDate.isBefore(today)) {
          recentData.add(payment);
        }
      }

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
