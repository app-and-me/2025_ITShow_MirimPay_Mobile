import 'package:get/get.dart';
import 'package:mirim_pay/pages/face_registration/viewmodels/face_registration_viewmodel.dart';

class FaceRegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FaceRegistrationViewModel>(() => FaceRegistrationViewModel());
  }
}
