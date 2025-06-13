import 'package:get/get.dart';
import 'package:mirim_pay/pages/password_reset/viewmodels/password_reset_confirm_viewmodel.dart';

class PasswordResetConfirmBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PasswordResetConfirmViewModel>(() => PasswordResetConfirmViewModel());
  }
}
