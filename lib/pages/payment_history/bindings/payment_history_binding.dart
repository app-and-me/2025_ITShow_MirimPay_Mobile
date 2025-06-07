import 'package:get/get.dart';
import 'package:mirim_pay/app/data/repositories/payment_history_repository.dart';
import 'package:mirim_pay/pages/payment_history/viewmodels/payment_history_viewmodel.dart';

class PaymentHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentHistoryRepository>(() => PaymentHistoryRepository());
    Get.lazyPut<PaymentHistoryViewModel>(() => PaymentHistoryViewModel());
  }
}
