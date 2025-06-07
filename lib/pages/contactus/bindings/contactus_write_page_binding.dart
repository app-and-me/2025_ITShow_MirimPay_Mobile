import 'package:get/get.dart';
import '../viewmodels/contactus_write_page_viewmodel.dart';
import '../../../app/data/repositories/contactus_write_repository.dart';

class ContactUsWritePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactUsWriteRepository>(() => ContactUsWriteRepositoryImpl());
    Get.lazyPut(() => ContactUsWritePageViewModel());
  }
}
