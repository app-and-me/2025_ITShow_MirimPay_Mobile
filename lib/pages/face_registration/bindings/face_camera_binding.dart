import 'package:get/get.dart';
import 'package:mirim_pay/app/data/repositories/face_registration_repository.dart';
import 'package:mirim_pay/pages/face_registration/viewmodels/face_camera_viewmodel.dart';

class FaceCameraBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FaceRegistrationRepository>(() => FaceRegistrationRepositoryImpl());
    Get.lazyPut<FaceCameraViewModel>(() => FaceCameraViewModel());
  }
}
