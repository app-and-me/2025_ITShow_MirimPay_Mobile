import 'package:get/get.dart';
import 'package:mirim_pay/pages/pin_setup/viewmodels/pin_setup_viewmodel.dart';

class PinSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PinSetupViewModel>(() => PinSetupViewModel());
  }
}
