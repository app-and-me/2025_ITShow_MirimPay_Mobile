import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirim_pay/pages/main/models/question_model.dart';
import 'package:mirim_pay/app/data/repositories/contact_repository.dart';
import 'package:mirim_pay/util/constants/app_constants.dart';

class ContactUsPageViewModel extends GetxController with WidgetsBindingObserver {
  final ContactRepository _contactRepository = Get.find<ContactRepository>();
  
  final RxBool isLoading = false.obs;
  final RxList<QuestionModel> allQuestions = <QuestionModel>[].obs;
  final RxList<QuestionModel> filteredQuestions = <QuestionModel>[].obs;
  final RxList<QuestionModel> displayedQuestions = <QuestionModel>[].obs;
  final RxInt selectedCategoryIndex = 0.obs;
  final RxString selectedDateFilter = '오늘'.obs;
  final RxBool showDivider = false.obs;
  final RxBool isSearching = false.obs;
  final RxString searchQuery = ''.obs;
  final TextEditingController searchController = TextEditingController();
  
  final RxList<String> categories = ['전체', '재고', '입고', '품절', '운영', '그 외'].obs;
  final RxList<String> dateFilters = ['오늘', '최근 7일', '최근 1개월'].obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    loadQuestions();
  }

  @override
  void onReady() {
    super.onReady();
    loadQuestions();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    searchController.dispose();
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      loadQuestions();
    }
  }

  void refreshData() {
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    isLoading.value = true;
    try {
      final questions = await _contactRepository.getQuestions();
      allQuestions.value = questions;
      _updateFilteredQuestions();
    } catch (e) {
      Get.snackbar(AppStrings.error, '문의 내역을 불러오는데 실패했습니다.');
    } finally {
      isLoading.value = false;
    }
  }

  void _updateFilteredQuestions() {
    final selectedCategory = categories[selectedCategoryIndex.value];
    List<QuestionModel> categoryFiltered;
    
    if (selectedCategoryIndex.value == 0) {
      categoryFiltered = allQuestions;
    } else {
      categoryFiltered = allQuestions.where((q) => q.category == selectedCategory).toList();
    }
    
    if (searchQuery.value.isNotEmpty) {
      filteredQuestions.value = categoryFiltered.where((q) => 
        q.title.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
        q.category.toLowerCase().contains(searchQuery.value.toLowerCase())
      ).toList();
    } else {
      filteredQuestions.value = categoryFiltered;
    }
    
    _updateDisplayedQuestions();
  }

  Map<String, List<QuestionModel>> get groupedQuestions {
    final questions = filteredQuestions;
    final today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final weekAgo = today.subtract(const Duration(days: 7));
    final monthAgo = today.subtract(const Duration(days: 30));

    final todayQuestions = <QuestionModel>[];
    final recentQuestions = <QuestionModel>[];
    final monthlyQuestions = <QuestionModel>[];

    for (var question in questions) {
      final parts = DateTime.parse(question.createdAt).toString().split(' ')[0].split('-');
      if (parts.length == 3) {
        final year = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        final day = int.parse(parts[2]);
        final questionDate = DateTime(year, month, day);

        if (questionDate.year == today.year &&
            questionDate.month == today.month &&
            questionDate.day == today.day) {
          todayQuestions.add(question);
        } else if (questionDate.isAfter(weekAgo)) {
          recentQuestions.add(question);
        } else if (questionDate.isAfter(monthAgo)) {
          monthlyQuestions.add(question);
        }
      }
    }

    return {
      '오늘': todayQuestions,
      '최근 7일': recentQuestions,
      '최근 1개월': monthlyQuestions,
    };
  }

  void _updateDisplayedQuestions() {
    final grouped = groupedQuestions;
    final filter = selectedDateFilter.value;
    
    if (filter == '오늘') {
      displayedQuestions.value = grouped['오늘'] ?? [];
    } else if (filter == '최근 7일') {
      displayedQuestions.value = [
        ...(grouped['오늘'] ?? []),
        ...(grouped['최근 7일'] ?? []),
      ];
    } else if (filter == '최근 1개월') {
      displayedQuestions.value = [
        ...(grouped['오늘'] ?? []),
        ...(grouped['최근 7일'] ?? []),
        ...(grouped['최근 1개월'] ?? []),
      ];
    } else {
      displayedQuestions.value = filteredQuestions;
    }
  }

  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
    _updateFilteredQuestions();
    update();
  }

  void selectDateFilter(String filter) {
    selectedDateFilter.value = filter;
    _updateDisplayedQuestions();
  }

  void updateDividerVisibility(bool show) {
    showDivider.value = show;
  }

  void navigateToWrite() {
    Get.toNamed(AppRoutes.contactUsWrite);
  }

  void onSearch() {
    isSearching.value = !isSearching.value;
    if (!isSearching.value) {
      searchController.clear();
      searchQuery.value = '';
      _updateFilteredQuestions();
    }
  }

  void onSearchChanged(String query) {
    searchQuery.value = query;
    _updateFilteredQuestions();
  }

  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
    isSearching.value = false;
    _updateFilteredQuestions();
  }
}
