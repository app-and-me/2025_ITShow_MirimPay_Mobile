import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mirim_pay/pages/face_registration/viewmodels/face_registration_viewmodel.dart';
import 'package:mirim_pay/util/style/colors.dart';
import 'package:mirim_pay/util/style/typography.dart';

class FaceRegistrationPage extends GetView<FaceRegistrationViewModel> {
  const FaceRegistrationPage({super.key});

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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 113),
                  SvgPicture.asset(
                    'assets/icons/face_id.svg',
                  ),
                  const SizedBox(height: 100),
                  Text(
                    '키오스크 얼굴 결제',
                    style: Typo.headlineSub(context, color: colors.gray900).copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '얼굴을 결제 수단에 등록한 후, 키오스크에서 얼굴을\n인식해 결제할 수 있어요',
                    style: Typo.bodySm(context, color: colors.gray700).copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            _buildRegisterButton(context, colors),
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
            style: Typo.headlineSub(context, color: colors.gray900),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context, ThemeColors colors) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Obx(() => SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed:
                  controller.isLoading.value ? null : controller.registerFace,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: colors.primary),
                ),
                elevation: 0,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: controller.isLoading.value
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: colors.primary,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        '얼굴 등록하기',
                        style: Typo.bodySm(context, color: colors.primary),
                      ),
                )
              ),
            ),
          )),
    );
  }
}
