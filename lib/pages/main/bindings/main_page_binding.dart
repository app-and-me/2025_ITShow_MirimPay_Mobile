import 'package:get/get.dart';
import 'package:mirim_pay/pages/main/viewmodels/pay_page_viewmodel.dart';
import 'package:mirim_pay/pages/main/viewmodels/product_page_viewmodel.dart';
import 'package:mirim_pay/pages/main/viewmodels/contactus_page_viewmodel.dart';
import 'package:mirim_pay/pages/main/viewmodels/me_page_viewmodel.dart';
import 'package:mirim_pay/app/data/repositories/card_repository.dart';
import 'package:mirim_pay/app/data/repositories/product_repository.dart';
import 'package:mirim_pay/app/data/repositories/contact_repository.dart';
import 'package:mirim_pay/app/data/repositories/user_repository.dart';

class MainPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CardRepository>(() => CardRepositoryImpl());
    Get.lazyPut<ProductRepository>(() => ProductRepositoryImpl());
    Get.lazyPut<ContactRepository>(() => ContactRepositoryImpl());
    Get.lazyPut<UserRepository>(() => UserRepositoryImpl());
    
    Get.lazyPut<PayPageViewModel>(() => PayPageViewModel());
    Get.lazyPut<ProductPageViewModel>(() => ProductPageViewModel());
    Get.lazyPut<ContactUsPageViewModel>(() => ContactUsPageViewModel());
    Get.lazyPut<MePageViewModel>(() => MePageViewModel());
  }
}
