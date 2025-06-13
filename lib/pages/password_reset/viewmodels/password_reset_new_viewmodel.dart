import 'package:get/get.dart';
import 'package:mirim_pay/util/constants/app_constants.dart';

class PasswordResetNewViewModel extends GetxController {
  final RxString pin = ''.obs;
  late String currentPin;
  
  @override
  void onInit() {
    super.onInit();
    currentPin = Get.arguments as String;
  }
  
  void addNumber(String number) {
    if (pin.value.length < 4) {
      pin.value += number;
      if (pin.value.length == 4) {
        _navigateToConfirm();
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
  
  void _navigateToConfirm() {
    Get.toNamed(AppRoutes.passwordResetConfirm, arguments: {
      'currentPin': currentPin,
      'newPin': pin.value,
    });
  }
}
