import 'package:get/get.dart';
import 'package:mirim_pay/pages/login/viewmodels/login_page_viewmodel.dart';
import 'package:mirim_pay/app/data/repositories/auth_repository.dart';

class LoginPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl());
    Get.lazyPut<LoginPageViewModel>(() => LoginPageViewModel());
  }
}