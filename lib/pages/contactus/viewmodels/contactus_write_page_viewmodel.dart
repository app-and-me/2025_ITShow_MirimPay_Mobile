import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/contactus_write_model.dart';
import '../../../app/data/repositories/contactus_write_repository.dart';

class ContactUsWritePageViewModel extends GetxController {
  final ContactUsWriteRepository _repository = Get.find<ContactUsWriteRepository>();
  
  final TextEditingController contentController = TextEditingController();
  final RxString _selectedCategory = '재고'.obs;
  final RxBool _isSubmitting = false.obs;

  String get selectedCategory => _selectedCategory.value;
  bool get isSubmitting => _isSubmitting.value;
  List<String> get categories => _repository.getCategories();
  
  RxString get selectedCategoryObs => _selectedCategory;
  RxBool get isSubmittingObs => _isSubmitting;
  
  bool get canSubmit => _selectedCategory.value.isNotEmpty && contentController.text.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    contentController.addListener(_updateSubmitButton);
  }

  @override
  void onClose() {
    contentController.removeListener(_updateSubmitButton);
    contentController.dispose();
    super.onClose();
  }

  void _updateSubmitButton() {
    update();
  }

  void selectCategory(String category) {
    _selectedCategory.value = category;
  }

  Future<void> submitContactUs() async {
    if (!canSubmit || _isSubmitting.value) return;

    try {
      _isSubmitting.value = true;
      
      final contactUs = ContactUsWriteModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        category: _selectedCategory.value,
        content: contentController.text,
        createdAt: DateTime.now(),
      );

      final success = await _repository.submitContactUs(contactUs);
      
      if (success) {
        Get.back();
        Get.snackbar('완료', '문의가 등록되었습니다.');
      } else {
        Get.snackbar('오류', '문의 등록에 실패했습니다.');
      }
    } catch (e) {
      Get.snackbar('오류', '문의 등록 중 문제가 발생했습니다.');
    } finally {
      _isSubmitting.value = false;
    }
  }

  void goBack() {
    Get.back();
  }
}
