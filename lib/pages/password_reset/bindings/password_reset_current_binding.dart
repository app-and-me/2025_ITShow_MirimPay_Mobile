import 'package:get/get.dart';
import 'package:mirim_pay/pages/password_reset/viewmodels/password_reset_current_viewmodel.dart';

class PasswordResetCurrentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PasswordResetCurrentViewModel>(() => PasswordResetCurrentViewModel());
  }
}
