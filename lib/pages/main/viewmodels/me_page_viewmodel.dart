import 'package:get/get.dart';
import 'package:mirim_pay/app/data/models/user_model.dart';
import 'package:mirim_pay/app/data/repositories/user_repository.dart';
import 'package:mirim_pay/pages/main/models/menu_item_model.dart';
import 'package:mirim_pay/util/constants/app_constants.dart';

class MePageViewModel extends GetxController {
  final UserRepository _userRepository = Get.find<UserRepository>();
  
  final RxBool isLoading = false.obs;
  final Rx<User?> currentUser = Rx<User?>(null);
  final RxBool hasNewNotification = false.obs;
  
  RxList<MenuItemModel> get menuItems => [
    MenuItemModel(title: AppStrings.paymentHistory),
    MenuItemModel(title: AppStrings.passwordReset),
    MenuItemModel(title: AppStrings.cardInfo),
    MenuItemModel(title: AppStrings.faceRegistration),
  ].obs;
  
  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }
  
  @override
  void onReady() {
    super.onReady();
    loadNotificationStatus();
  }
  
  Future<void> loadNotificationStatus() async {
    try {
      final hasNotifications = await _userRepository.hasNewNotifications();
      hasNewNotification.value = hasNotifications;
    } catch (_) {
    }
  }
  
  Future<void> loadUserData() async {
    isLoading.value = true;
    try {
      final user = await _userRepository.getCurrentUser();
      currentUser.value = user;
      
      final hasNotifications = await _userRepository.hasNewNotifications();
      hasNewNotification.value = hasNotifications;
    } catch (e) {
      Get.snackbar(AppStrings.error, AppStrings.userDataError);
    } finally {
      isLoading.value = false;
    }
  }
  
  void onMenuItemTap(int index) {
    switch (index) {
      case 0:
        navigateToPaymentHistory();
        break;
      case 1:
        navigateToPasswordReset();
        break;
      case 2:
        navigateToCardInfo();
        break;
      case 3:
        navigateToFaceRegistration();
        break;
    }
  }
   void navigateToPaymentHistory() {
    Get.toNamed(AppRoutes.paymentHistory);
  }
  
  void navigateToPasswordReset() {
    Get.toNamed('password-reset-current');
  }

  void navigateToCardInfo() {
    Get.toNamed(AppRoutes.cardInfo);
  }

  void navigateToFaceRegistration() {
    Get.toNamed(AppRoutes.faceRegistration);
  }
  
  void navigateToAlert() {
    Get.toNamed(AppRoutes.alert);
  }
  
  Future<void> logout() async {
    isLoading.value = true;
    try {
      await _userRepository.logout();
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      Get.snackbar(AppStrings.error, AppStrings.logoutError);
    } finally {
      isLoading.value = false;
    }
  }
  
  String get userName => currentUser.value?.nickname ?? AppStrings.defaultName;
  String get alertIconPathDark => hasNewNotification.value 
      ? 'assets/icons/alert_exist_dark.svg' 
      : 'assets/icons/alert_default_dark.svg';

  String get alertIconPathLight => hasNewNotification.value 
      ? 'assets/icons/alert_exist_light.svg' 
      : 'assets/icons/alert_default_light.svg';

}
