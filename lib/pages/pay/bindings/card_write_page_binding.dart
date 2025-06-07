import 'package:get/get.dart';
import '../viewmodels/card_write_page_viewmodel.dart';
import '../../../app/data/repositories/card_write_repository.dart';

class CardWritePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CardWriteRepository>(() => CardWriteRepositoryImpl());
    Get.lazyPut(() => CardWritePageViewModel());
  }
}
