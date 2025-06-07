import 'package:get/get.dart';
import '../viewmodels/alert_page_viewmodel.dart';
import '../../../app/data/repositories/alert_repository.dart';

class AlertPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AlertRepository>(() => AlertRepositoryImpl());
    Get.lazyPut(() => AlertPageViewModel());
  }
}
