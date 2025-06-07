import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirim_pay/pages/main/models/product_model.dart';
import 'package:mirim_pay/app/data/repositories/product_repository.dart';
import 'package:mirim_pay/util/constants/app_constants.dart';

class ProductPageViewModel extends GetxController {
  final ProductRepository _productRepository = Get.find<ProductRepository>();
  
  final RxBool isLoading = false.obs;
  final RxList<ProductModel> allProducts = <ProductModel>[].obs;
  final RxList<ProductModel> filteredProducts = <ProductModel>[].obs;
  final RxInt selectedCategoryIndex = 0.obs;
  final RxBool showDivider = false.obs;
  final ScrollController scrollController = ScrollController();
  
  final RxList<String> categories = [
    '전체',
    '과자',
    '음료수',
    '빵',
    '우유',
    '냉동식품',
    '아이스크림',
    '젤리',
  ].obs;

  String get selectedCategory => categories[selectedCategoryIndex.value];

  @override
  void onInit() {
    super.onInit();
    loadProducts();
    scrollController.addListener(_scrollListener);
  }

  @override
  void onClose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.onClose();
  }

  void _scrollListener() {
    final shouldShowDivider = scrollController.offset > 50;
    if (shouldShowDivider != showDivider.value) {
      showDivider.value = shouldShowDivider;
    }
  }

  Future<void> loadProducts() async {
    isLoading.value = true;
    try {
      final products = await _productRepository.getProducts();
      allProducts.value = products;
      _updateFilteredProducts();
    } catch (e) {
      Get.snackbar(AppStrings.error, '상품 정보를 불러오는데 실패했습니다.');
    } finally {
      isLoading.value = false;
    }
  }

  void _updateFilteredProducts() {
    final selectedCategory = categories[selectedCategoryIndex.value];
    if (selectedCategoryIndex.value == 0) {
      filteredProducts.value = allProducts;
    } else {
      filteredProducts.value = allProducts.where((p) => p.category == selectedCategory).toList();
    }
  }

  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
    _updateFilteredProducts();
    update();
  }

  void updateDividerVisibility(bool show) {
    showDivider.value = show;
  }

  void onSearch() {
    // TODO: Implement search functionality
  }
}