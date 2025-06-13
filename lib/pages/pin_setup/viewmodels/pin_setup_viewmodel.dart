import 'package:get/get.dart';
import 'package:mirim_pay/util/constants/app_constants.dart';

class PinSetupViewModel extends GetxController {
  final RxString pin = ''.obs;
  
  void addNumber(String number) {
    if (pin.value.length < 4) {
      pin.value += number;
      if (pin.value.length == 4) {
        Get.toNamed(AppRoutes.pinConfirm, arguments: pin.value);
      }
    }
  }
  
  void deleteOne() {
    if (pin.value.isNotEmpty) {
      pin.value = pin.value.substring(0, pin.value.length - 1);
    }
  }
  
  void clearAll() {
    pin.value = '';
  }
}
