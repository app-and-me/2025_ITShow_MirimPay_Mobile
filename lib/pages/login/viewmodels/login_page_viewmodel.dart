import 'package:get/get.dart';
import 'package:mirim_pay/app/data/repositories/auth_repository.dart';
import 'package:mirim_pay/util/constants/app_constants.dart';

class LoginPageViewModel extends GetxController {
  final AuthRepository _authRepository = Get.find<AuthRepository>();
  
  final RxBool isLoading = false.obs;
  
  Future<void> login() async {
    isLoading.value = true;
    try {
      final userExists = await _authRepository.login();
      if (userExists) {
        Get.offAllNamed(AppRoutes.main);
      } else {
        Get.offAllNamed('/pin-setup');
      }
    } catch (e) {
      Get.snackbar(
        AppStrings.loginFailed,
        AppStrings.tryAgain,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
