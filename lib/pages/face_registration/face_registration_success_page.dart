import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mirim_pay/pages/face_registration/viewmodels/face_registration_success_viewmodel.dart';
import 'package:mirim_pay/util/style/colors.dart';
import 'package:mirim_pay/util/style/typography.dart';

class FaceRegistrationSuccessPage extends GetView<FaceRegistrationSuccessViewModel> {
  const FaceRegistrationSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);

    return Scaffold(
      backgroundColor: colors.gray50,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, colors),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/face_registration_success.svg',
                  ),
                  const SizedBox(height: 70),
                  Text(
                    '얼굴 등록이 완료되었어요',
                    style: Typo.headlineSub(context, color: colors.gray900).copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '이제 핸드폰이 없어도 얼굴 인식으로\n편하게 결제할 수 있어요',
                    style: Typo.bodySm(context, color: colors.gray700).copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ThemeColors colors) {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 21),
      child: Row(
        children: [
          GestureDetector(
            onTap: controller.goBack,
            child: SvgPicture.asset(
              'assets/icons/arrow_left.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                colors.gray900,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            '얼굴 결제 등록',
            style: Typo.headlineSub(context, color: colors.gray900)
          ),
        ],
      ),
    );
  }
}
