import 'package:get/get.dart';
import '../viewmodels/product_page_viewmodel.dart';
import '../../../app/data/repositories/product_repository.dart';

class ProductPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductRepository>(() => ProductRepositoryImpl());
    Get.lazyPut(() => ProductPageViewModel());
  }
}