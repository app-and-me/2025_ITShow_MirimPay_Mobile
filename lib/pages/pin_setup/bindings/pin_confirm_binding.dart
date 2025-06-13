import 'package:get/get.dart';
import 'package:mirim_pay/pages/pin_setup/viewmodels/pin_confirm_viewmodel.dart';

class PinConfirmBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PinConfirmViewModel>(() => PinConfirmViewModel());
  }
}
