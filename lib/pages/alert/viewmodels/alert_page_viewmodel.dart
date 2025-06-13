import 'package:get/get.dart';
import '../models/alert_model.dart';
import '../../../app/data/repositories/alert_repository.dart';
import '../../main/viewmodels/pay_page_viewmodel.dart';
import '../../main/viewmodels/me_page_viewmodel.dart';

class AlertPageViewModel extends GetxController {
  final AlertRepository _alertRepository = Get.find<AlertRepository>();
  
  final RxList<AlertModel> _alerts = <AlertModel>[].obs;
  final RxBool _isLoading = false.obs;

  List<AlertModel> get alerts => _alerts;
  bool get isLoading => _isLoading.value;
  bool get hasAlerts => _alerts.isNotEmpty;
  
  RxList<AlertModel> get alertsObs => _alerts;
  RxBool get isLoadingObs => _isLoading;

  @override
  void onInit() {
    super.onInit();
    loadAlerts();
  }

  Future<void> loadAlerts() async {
    try {
      _isLoading.value = true;
      final alerts = await _alertRepository.getRecentAlerts();
      _alerts.value = alerts;
    } catch (e) {
      Get.snackbar('오류', '알림을 불러오는 중 문제가 발생했습니다.');
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> markAsRead(int alertId) async {
    try {
      await _alertRepository.markAsRead(alertId);
      
      final index = _alerts.indexWhere((alert) => alert.id == alertId);
      if (index != -1) {
        final alert = _alerts[index];
        _alerts[index] = AlertModel(
          id: alert.id,
          type: alert.type,
          message: alert.message,
          date: alert.date,
          isRead: true,
        );
      }
      
      _updateOtherPagesNotificationStatus();
    } catch (e) {
      Get.snackbar('오류', '알림 읽기 처리 중 문제가 발생했습니다.');
    }
  }
  
  void _updateOtherPagesNotificationStatus() {
    try {
      if (Get.isRegistered<PayPageViewModel>()) {
        final payPageController = Get.find<PayPageViewModel>();
        payPageController.loadNotificationStatus();
      }
      
      if (Get.isRegistered<MePageViewModel>()) {
        final mePageController = Get.find<MePageViewModel>();
        mePageController.loadUserData();
      }
    } catch (_) {
    }
  }

  void goBack() {
    Get.back();
  }
}