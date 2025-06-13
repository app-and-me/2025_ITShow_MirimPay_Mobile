import 'package:get/get.dart';
import 'package:mirim_pay/pages/main/viewmodels/pay_page_viewmodel.dart';
import 'package:mirim_pay/app/data/repositories/card_repository.dart';
import 'package:mirim_pay/app/data/repositories/alert_repository.dart';

class PayPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CardRepository>(() => CardRepositoryImpl());
    Get.lazyPut<AlertRepository>(() => AlertRepositoryImpl());
    Get.lazyPut<PayPageViewModel>(() => PayPageViewModel());
  }
}
