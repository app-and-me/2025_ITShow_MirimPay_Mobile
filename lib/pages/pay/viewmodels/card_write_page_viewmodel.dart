import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/card_write_model.dart';
import '../../../app/data/repositories/card_write_repository.dart';

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
    // 카드 번호: 16자리 숫자 (하이픈 제거 후)
    final cardNumberClean = cardNumberController.text.replaceAll(RegExp(r'[^0-9]'), '');
    final isCardNumberValid = cardNumberClean.length == 16;
    
    // 유효기간: 4자리 숫자 (MMYY)
    final isExpirationValid = expirationController.text.length == 4;
    
    // CVC: 3자리 숫자
    final isCvcValid = cvcController.text.length == 3;
    
    // 카드 비밀번호: 2자리 숫자
    final isPasswordValid = passwordController.text.length == 2;
    
    // 생년월일: 6자리 숫자 (YYMMDD)
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
        cardNumber: cardNumberController.text,
        expiration: expirationController.text,
        cvc: cvcController.text,
        password: passwordController.text,
        birthDate: birthDateController.text,
        createdAt: DateTime.now(),
      );

      final isValid = await _repository.validateCard(card);
      if (!isValid) {
        Get.snackbar('오류', '카드 정보를 확인해주세요.');
        return;
      }

      final success = await _repository.saveCard(card);

      if (success) {
        Get.back();
        Get.snackbar('완료', '카드가 등록되었습니다.');
      } else {
        Get.snackbar('오류', '카드 등록에 실패했습니다.');
      }
    } catch (e) {
      Get.snackbar('오류', '카드 등록 중 문제가 발생했습니다.');
    } finally {
      _isSubmitting.value = false;
    }
  }

  String formatCardNumber(String value) {
    value = value.replaceAll(' ', '');
    String formatted = '';
    for (int i = 0; i < value.length; i++) {
      if (i > 0 && i % 4 == 0) {
        formatted += ' ';
      }
      formatted += value[i];
    }
    return formatted;
  }

  void goBack() {
    Get.back();
  }
}
