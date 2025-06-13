import 'package:get/get.dart';
import 'package:mirim_pay/pages/password_reset/viewmodels/password_reset_new_viewmodel.dart';

class PasswordResetNewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PasswordResetNewViewModel>(() => PasswordResetNewViewModel());
  }
}
