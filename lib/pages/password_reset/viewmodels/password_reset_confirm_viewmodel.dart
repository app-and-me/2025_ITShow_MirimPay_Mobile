import 'package:get/get.dart';
import 'package:mirim_pay/app/data/repositories/user_repository.dart';
import 'package:mirim_pay/util/constants/app_constants.dart';

class PasswordResetConfirmViewModel extends GetxController {
  final UserRepository _userRepository = Get.find<UserRepository>();
  final RxString pin = ''.obs;
  final RxBool isUpdating = false.obs;
  late String currentPin;
  late String newPin;
  
  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, String>;
    currentPin = arguments['currentPin']!;
    newPin = arguments['newPin']!;
  }
  
  void addNumber(String number) {
    if (pin.value.length < 4) {
      pin.value += number;
      if (pin.value.length == 4) {
        _confirmNewPin();
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
  
  Future<void> _confirmNewPin() async {
    if (pin.value != newPin) {
      Get.snackbar('오류', '비밀번호가 일치하지 않습니다.');
      pin.value = '';
      return;
    }
    
    await _updatePassword();
  }
  
  Future<void> _updatePassword() async {
    if (isUpdating.value) return;
    
    try {
      isUpdating.value = true;
      
      final success = await _userRepository.updatePin(currentPin, pin.value);
      
      if (success) {
        Get.offAllNamed(AppRoutes.main);
        Get.snackbar('완료', '결제 비밀번호가 성공적으로 변경되었습니다.');
      } else {
        Get.snackbar('오류', '비밀번호 변경에 실패했습니다.');
        pin.value = '';
      }
    } catch (e) {
      Get.snackbar('오류', '비밀번호 변경 중 문제가 발생했습니다.');
      pin.value = '';
    } finally {
      isUpdating.value = false;
    }
  }
}
