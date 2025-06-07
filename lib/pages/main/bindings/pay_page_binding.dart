import 'package:get/get.dart';
import 'package:mirim_pay/pages/main/viewmodels/pay_page_viewmodel.dart';
import 'package:mirim_pay/app/data/repositories/card_repository.dart';

class PayPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CardRepository>(() => CardRepositoryImpl());
    Get.lazyPut<PayPageViewModel>(() => PayPageViewModel());
  }
}
