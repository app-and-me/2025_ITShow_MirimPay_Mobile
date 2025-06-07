import 'package:get/get.dart';

class FaceRegistrationViewModel extends GetxController {
  final RxBool isLoading = false.obs;
  
  Future<void> registerFace() async {
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(seconds: 2));
      Get.snackbar('성공', '얼굴 등록이 완료되었습니다.');
    } catch (e) {
      Get.snackbar('오류', '얼굴 등록에 실패했습니다.');
    } finally {
      isLoading.value = false;
    }
  }
  
  void goBack() {
    Get.back();
  }
}
