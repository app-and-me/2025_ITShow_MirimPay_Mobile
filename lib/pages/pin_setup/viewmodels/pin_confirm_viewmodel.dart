import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:mirim_pay/util/constants/app_constants.dart';
import 'package:mirim_pay/util/service/auth_service.dart';
import 'package:http/http.dart' as http;

class PinConfirmViewModel extends GetxController {
  final RxString pin = ''.obs;
  final RxBool isCreating = false.obs;
  late String originalPin;
  
  @override
  void onInit() {
    super.onInit();
    originalPin = Get.arguments as String;
  }
  
  void addNumber(String number) {
    if (pin.value.length < 4) {
      pin.value += number;
      if (pin.value.length == 4) {
        _confirmPin();
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
  
  Future<void> _confirmPin() async {
    if (pin.value != originalPin) {
      Get.snackbar('오류', '비밀번호가 일치하지 않습니다.');
      pin.value = '';
      return;
    }
    
    await _createUser();
  }
  
  Future<void> _createUser() async {
    if (isCreating.value) return;
    
    try {
      isCreating.value = true;
      
      final baseUrl = dotenv.env['BASE_URL'];
      
      final response = await http.post(
        Uri.parse('$baseUrl/users/'),
        headers: await AppConstants.getHeaders(),
        body: jsonEncode({
          'id': int.parse(auth.currentUser?.id ?? '0'),
          'nickname': '${auth.currentUser?.nickname}',
          'pin': pin.value,
        }),
      );
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.offAllNamed('/');
        Get.snackbar('완료', '결제 비밀번호가 설정되었습니다.');
      } else {
        Get.snackbar('오류', '사용자 생성에 실패했습니다.');
        pin.value = '';
      }
    } catch (e) {
      Get.snackbar('오류', '사용자 생성 중 문제가 발생했습니다.');
      pin.value = '';
    } finally {
      isCreating.value = false;
    }
  }
}
