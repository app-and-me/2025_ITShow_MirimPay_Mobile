import 'package:get/get.dart';
import 'package:mirim_pay/pages/main/viewmodels/contactus_page_viewmodel.dart';
import 'package:mirim_pay/app/data/repositories/contact_repository.dart';

class ContactUsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactRepository>(() => ContactRepositoryImpl());
    Get.lazyPut<ContactUsPageViewModel>(() => ContactUsPageViewModel());
  }
}
