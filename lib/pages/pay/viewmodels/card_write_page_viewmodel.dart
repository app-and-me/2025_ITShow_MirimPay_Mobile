import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/card_write_model.dart';
import '../../../app/data/repositories/card_write_repository.dart';
import '../../main/viewmodels/pay_page_viewmodel.dart';

class CardWritePageViewModel extends GetxController {
  final CardWriteRepository _repository = Get.find<CardWriteRepository>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expirationController = TextEditingController();
  final TextEditingController cvcController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();

  final RxBool _isSubmitting = false.obs;
  final RxBool _isValidating = false.obs;
  final RxBool _isFormValid = false.obs;

  bool get isSubmitting => _isSubmitting.value;
  bool get isValidating => _isValidating.value;
  bool get isFormValid => _isFormValid.value;
  
  RxBool get isSubmittingObs => _isSubmitting;
  RxBool get isValidatingObs => _isValidating;
  RxBool get isFormValidObs => _isFormValid;

  @override
  void onInit() {
    super.onInit();
    _setupListeners();
  }

  void _setupListeners() {
    cardNumberController.addListener(_validateForm);
    expirationController.addListener(_validateForm);
    cvcController.addListener(_validateForm);
    passwordController.addListener(_validateForm);
    birthDateController.addListener(_validateForm);
  }

  void _validateForm() {
    final cardNumberClean = cardNumberController.text.replaceAll(RegExp(r'[^0-9]'), '');
    final isCardNumberValid = cardNumberClean.length == 16;
    
    final isExpirationValid = expirationController.text.length == 5;
    
    final isCvcValid = cvcController.text.length == 3;
    
    final isPasswordValid = passwordController.text.length == 2;
    
    final isBirthDateValid = birthDateController.text.length == 6;
    
    _isFormValid.value = isCardNumberValid &&
        isExpirationValid &&
        isCvcValid &&
        isPasswordValid &&
        isBirthDateValid;
  }

  @override
  void onClose() {
    cardNumberController.removeListener(_validateForm);
    expirationController.removeListener(_validateForm);
    cvcController.removeListener(_validateForm);
    passwordController.removeListener(_validateForm);
    birthDateController.removeListener(_validateForm);
    
    cardNumberController.dispose();
    expirationController.dispose();
    cvcController.dispose();
    passwordController.dispose();
    birthDateController.dispose();
    super.onClose();
  }

  Future<void> saveCard() async {
    if (!isFormValid || _isSubmitting.value) return;

    try {
      _isSubmitting.value = true;

      final card = CardWriteModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        cardNumber: cardNumberController.text.replaceAll(' ', '').replaceAll('-', ''),
        expiryYear: expirationController.text.substring(3, 5),
        expiryMonth: expirationController.text.substring(0, 2),
        cvc: cvcController.text,
        cardPassword: passwordController.text,
        identityNumber: birthDateController.text,
        createdAt: DateTime.now(),
      );

      final success = await _repository.saveCard(card);

      if (success) {
        Get.back();
        Get.snackbar('완료', '카드가 등록되었습니다.');
        
        try {
          final payPageController = Get.find<PayPageViewModel>();
          await payPageController.refreshCards();
        } catch (_) {
        }
      } else {
        Get.snackbar('오류', '카드 등록에 실패했습니다.');
      }
    } catch (e) {
      Get.snackbar('오류', '카드 등록 중 문제가 발생했습니다.');
    } finally {
      _isSubmitting.value = false;
    }
  }

  void goBack() {
    Get.back();
  }
}
