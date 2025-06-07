import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mirim_pay/util/style/colors.dart';
import 'package:mirim_pay/util/style/typography.dart';
import 'viewmodels/card_write_page_viewmodel.dart';

class CardWritePage extends GetView<CardWritePageViewModel> {
  const CardWritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);

    return Scaffold(
      backgroundColor: colors.gray50,
      appBar: AppBar(
        backgroundColor: colors.gray50,
        automaticallyImplyLeading: false,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: colors.gray300,
            height: 1.0,
          ),
        ),
        title: Text(
          '카드 정보 입력',
          style: Typo.headlineSub(context, color: colors.gray900),
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/cancel.svg',
              colorFilter: ColorFilter.mode(
                colors.gray500,
                BlendMode.srcIn,
              ),
              width: 36,
              height: 36,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text('카드 번호', style: Typo.bodySm(context, color: colors.gray800)),
              const SizedBox(height: 8),
              IntrinsicWidth(
                child: Container(
                  constraints: const BoxConstraints(minWidth: 200),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: colors.gray300,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: TextFormField(
                    controller: controller.cardNumberController,
                    style: Typo.bodyMd(context, color: colors.gray800)
                        .copyWith(fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      hintText: '0000    -    0000    -    0000    -    0000',
                      hintStyle: Typo.bodyMd(context, color: colors.gray400)
                          .copyWith(fontWeight: FontWeight.w400),
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(16),
                      _CardNumberFormatter(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 64),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('유효기간',
                          style: Typo.bodySm(context, color: colors.gray800)),
                      const SizedBox(height: 8),
                      IntrinsicWidth(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: colors.gray300,
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: TextFormField(
                            controller: controller.expirationController,
                            style: Typo.bodyMd(context, color: colors.gray800)
                                .copyWith(fontWeight: FontWeight.w400),
                            decoration: InputDecoration(
                              hintText: 'MMYY',
                              hintStyle:
                                  Typo.bodyMd(context, color: colors.gray400)
                                      .copyWith(fontWeight: FontWeight.w400),
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 32),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CVC',
                        style: Typo.bodySm(context, color: colors.gray800),
                      ),
                      const SizedBox(height: 8),
                      IntrinsicWidth(
                        child: Container(
                          constraints: const BoxConstraints(minWidth: 120),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: colors.gray300,
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: TextFormField(
                            controller: controller.cvcController,
                            style: Typo.bodyMd(context, color: colors.gray800)
                                .copyWith(fontWeight: FontWeight.w400),
                            decoration: InputDecoration(
                              hintText: '카드 뒷면 3자리 숫자',
                              hintStyle:
                                  Typo.bodyMd(context, color: colors.gray400)
                                      .copyWith(fontWeight: FontWeight.w400),
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(3),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 64),
              Text(
                '카드 비밀번호',
                style: Typo.bodySm(context, color: colors.gray800),
              ),
              const SizedBox(height: 8),
              IntrinsicWidth(
                child: Container(
                  constraints: const BoxConstraints(minWidth: 120),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: colors.gray300,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: TextFormField(
                    controller: controller.passwordController,
                    style: Typo.bodyMd(context, color: colors.gray800)
                        .copyWith(fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      hintText: '비밀번호 앞 2자리 숫자',
                      hintStyle: Typo.bodyMd(context, color: colors.gray400)
                          .copyWith(fontWeight: FontWeight.w400),
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(2),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 64),
              Text(
                '생년월일',
                style: Typo.bodySm(context, color: colors.gray800),
              ),
              const SizedBox(height: 8),
              IntrinsicWidth(
                child: Container(
                  constraints: const BoxConstraints(minWidth: 100),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: colors.gray300,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: TextFormField(
                    controller: controller.birthDateController,
                    style: Typo.bodyMd(context, color: colors.gray800)
                        .copyWith(fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      hintText: 'YYMMDD',
                      hintStyle: Typo.bodyMd(context, color: colors.gray400)
                          .copyWith(fontWeight: FontWeight.w400),
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Center(
                child: Obx(() => controller.isSubmittingObs.value
                    ? Container(
                        width: double.infinity,
                        height: 46,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: colors.gray500,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(colors.gray500),
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          if (controller.formKey.currentState!.validate() &&
                              controller.isFormValid) {
                            controller.saveCard();
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          height: 46,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: controller.isFormValid
                                  ? colors.primary
                                  : colors.gray500,
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '완료',
                              style: Typo.bodyMd(context, 
                                  color: controller.isFormValid
                                      ? colors.primary
                                      : colors.gray500),
                            ),
                          ),
                        ),
                      )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    String text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if ((i + 1) % 4 == 0 && i != text.length - 1) {
        buffer.write('    -    ');
      }
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}
