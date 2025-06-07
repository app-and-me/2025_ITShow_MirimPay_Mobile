import 'package:get/get.dart';
import 'package:mirim_pay/app/data/repositories/card_repository.dart';
import 'package:mirim_pay/pages/card_info/viewmodels/card_info_viewmodel.dart';

class CardInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CardRepository>(() => CardRepositoryImpl());
    Get.lazyPut<CardInfoViewModel>(() => CardInfoViewModel());
  }
}
