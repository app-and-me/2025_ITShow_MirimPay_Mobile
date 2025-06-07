import 'package:get/get.dart';
import '../models/alert_model.dart';
import '../../../app/data/repositories/alert_repository.dart';

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

  void goBack() {
    Get.back();
  }
}