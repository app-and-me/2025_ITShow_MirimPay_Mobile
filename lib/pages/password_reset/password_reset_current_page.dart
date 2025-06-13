import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mirim_pay/pages/password_reset/viewmodels/password_reset_current_viewmodel.dart';
import 'package:mirim_pay/util/style/colors.dart';
import 'package:mirim_pay/util/style/typography.dart';

class PasswordResetCurrentPage extends GetView<PasswordResetCurrentViewModel> {
  const PasswordResetCurrentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);
    
    return Scaffold(
      backgroundColor: colors.gray50,
      appBar: AppBar(
        backgroundColor: colors.gray50,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/arrow_back.svg',
            colorFilter: ColorFilter.mode(
              colors.gray900,
              BlendMode.srcIn,
            ),
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '결제 비밀번호 입력',
                  style: Typo.headlineMd(context, color: colors.gray900),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  '현재 결제 비밀번호 4자리를 입력해주세요',
                  style: Typo.bodySm(context, color: colors.gray700),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 64),
                Obx(() => _buildPinDots(colors)),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: _buildKeypad(colors, context),
          ),
        ],
      ),
    );
  }

  Widget _buildPinDots(ThemeColors colors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        final isEntered = index < controller.pin.value.length;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: isEntered ? colors.gray800 : colors.gray300,
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }

  Widget _buildKeypad(ThemeColors colors, BuildContext context) {
    return Container(
      width: double.infinity,
      color: colors.gray0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Column(
          children: [
            Expanded(child: _buildKeypadRow(['1', '2', '3'], colors, context)),
            Expanded(child: _buildKeypadRow(['4', '5', '6'], colors, context)),
            Expanded(child: _buildKeypadRow(['7', '8', '9'], colors, context)),
            Expanded(child: _buildBottomRow(colors, context)),
          ],
        ),
      ),
    );
  }

  Widget _buildKeypadRow(List<String> numbers, ThemeColors colors, BuildContext context) {
    return Row(
      children: numbers.map((number) => 
        Expanded(
          child: _buildKeypadButton(number, colors, context),
        )
      ).toList(),
    );
  }

  Widget _buildBottomRow(ThemeColors colors, BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildSpecialButton(
            onTap: controller.clearAll,
            child: Text(
              '전체삭제',
              style: Typo.bodySm(context, color: colors.gray900),
            ),
          ),
        ),
        Expanded(
          child: _buildKeypadButton('0', colors, context),
        ),
        Expanded(
          child: _buildSpecialButton(
            onTap: controller.deleteOne,
            child: SvgPicture.asset(
              'assets/icons/delete_button.svg',
              colorFilter: ColorFilter.mode(
                colors.gray900,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildKeypadButton(String number, ThemeColors colors, BuildContext context) {
    return GestureDetector(
      onTap: () => controller.addNumber(number),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Text(
          number,
          style: Typo.headlineSub(context, color: colors.gray900)
        ),
      ),
    );
  }

  Widget _buildSpecialButton({required VoidCallback onTap, required Widget child}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
