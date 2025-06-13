import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirim_pay/pages/main/models/product_model.dart';
import 'package:mirim_pay/app/data/repositories/product_repository.dart';
import 'package:mirim_pay/util/constants/app_constants.dart';

class ProductPageViewModel extends GetxController with WidgetsBindingObserver {
  final ProductRepository _productRepository = Get.find<ProductRepository>();
  
  final RxBool isLoading = false.obs;
  final RxList<ProductModel> allProducts = <ProductModel>[].obs;
  final RxList<ProductModel> filteredProducts = <ProductModel>[].obs;
  final RxInt selectedCategoryIndex = 0.obs;
  final RxBool showDivider = false.obs;
  final RxBool isSearching = false.obs;
  final RxString searchQuery = ''.obs;
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  
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
    WidgetsBinding.instance.addObserver(this);
    loadProducts();
    scrollController.addListener(_scrollListener);
  }

  @override
  void onReady() {
    super.onReady();
    loadProducts();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    searchController.dispose();
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      loadProducts();
    }
  }

  void refreshData() {
    loadProducts();
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
    List<ProductModel> categoryFiltered;
    
    if (selectedCategoryIndex.value == 0) {
      categoryFiltered = allProducts;
    } else {
      categoryFiltered = allProducts.where((p) => p.category == selectedCategory).toList();
    }
    
    if (searchQuery.value.isNotEmpty) {
      filteredProducts.value = categoryFiltered.where((p) => 
        p.name.toLowerCase().contains(searchQuery.value.toLowerCase())
      ).toList();
    } else {
      filteredProducts.value = categoryFiltered;
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
    isSearching.value = !isSearching.value;
    if (!isSearching.value) {
      searchController.clear();
      searchQuery.value = '';
      _updateFilteredProducts();
    }
  }

  void onSearchChanged(String query) {
    searchQuery.value = query;
    _updateFilteredProducts();
  }

  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
    isSearching.value = false;
    _updateFilteredProducts();
  }
}