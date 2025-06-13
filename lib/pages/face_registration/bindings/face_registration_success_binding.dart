import 'package:get/get.dart';
import 'package:mirim_pay/pages/face_registration/viewmodels/face_registration_success_viewmodel.dart';

class FaceRegistrationSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FaceRegistrationSuccessViewModel>(() => FaceRegistrationSuccessViewModel());
  }
}
