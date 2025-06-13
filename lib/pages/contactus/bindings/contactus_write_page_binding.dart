import 'package:get/get.dart';
import '../viewmodels/contactus_write_page_viewmodel.dart';
import '../../../app/data/repositories/contact_repository.dart';

class ContactUsWritePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactRepository>(() => ContactRepositoryImpl());
    Get.lazyPut(() => ContactUsWritePageViewModel());
  }
}
