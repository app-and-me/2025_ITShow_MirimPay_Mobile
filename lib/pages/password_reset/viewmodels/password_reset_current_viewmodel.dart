import 'package:get/get.dart';
import 'package:mirim_pay/app/data/repositories/user_repository.dart';
import 'package:mirim_pay/util/constants/app_constants.dart';

class PasswordResetCurrentViewModel extends GetxController {
  final UserRepository _userRepository = Get.find<UserRepository>();
  final RxString pin = ''.obs;
  final RxBool isVerifying = false.obs;
  
  void addNumber(String number) {
    if (pin.value.length < 4) {
      pin.value += number;
      if (pin.value.length == 4) {
        _verifyCurrentPin();
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
  
  Future<void> _verifyCurrentPin() async {
    if (isVerifying.value) return;
    
    try {
      isVerifying.value = true;
      
      final isValid = await _userRepository.verifyCurrentPin(pin.value);
      
      if (isValid) {
        Get.toNamed(AppRoutes.passwordResetNew, arguments: pin.value);
      } else {
        Get.snackbar('오류', '현재 비밀번호가 올바르지 않습니다.');
        pin.value = '';
      }
    } catch (e) {
      Get.snackbar('오류', '비밀번호 확인 중 문제가 발생했습니다.');
      pin.value = '';
    } finally {
      isVerifying.value = false;
    }
  }
}
