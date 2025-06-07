import 'package:get/get.dart';
import 'package:mirim_pay/pages/main/viewmodels/me_page_viewmodel.dart';
import 'package:mirim_pay/app/data/repositories/user_repository.dart';

class MePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserRepository>(() => UserRepositoryImpl());
    Get.lazyPut<MePageViewModel>(() => MePageViewModel());
  }
}
