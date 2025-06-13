import 'package:get/get.dart';
import 'package:mirim_pay/util/constants/app_constants.dart';

class FaceRegistrationViewModel extends GetxController {
  final RxBool isLoading = false.obs;
  
  Future<void> registerFace() async {
    Get.toNamed(AppRoutes.faceCamera);
  }
  
  void goBack() {
    Get.back();
  }
}
