import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mirim_pay/pages/face_registration/viewmodels/face_camera_viewmodel.dart';
import 'package:mirim_pay/util/style/colors.dart';
import 'package:mirim_pay/util/style/typography.dart';

class FaceCameraPage extends GetView<FaceCameraViewModel> {
  const FaceCameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);

    return Scaffold(
      backgroundColor: colors.gray50,
      body: SafeArea(
        child: Obx(() {
          if (controller.hasError.value) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '카메라 오류',
                    style: Typo.headlineSub(context, color: colors.gray900),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      controller.errorMessage.value,
                      style: Typo.bodyMd(context, color: colors.gray700),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (controller.errorMessage.value.contains('영구적으로 거부'))
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            controller.openDeviceSettings();
                          },
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(color: colors.primary, width: 1),
                            backgroundColor: colors.gray50,
                            foregroundColor: colors.gray900,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text('설정으로 이동'),
                        ),
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: () {
                            controller.retryInitializeCamera();
                          },
                          child: Text(
                            '다시 시도',
                            style: TextStyle(color: colors.primary),
                          ),
                        ),
                      ],
                    )
                  else
                    ElevatedButton(
                      onPressed: () {
                        controller.retryInitializeCamera();
                      },
                      child: const Text('다시 시도'),
                    ),
                ],
              ),
            );
          }

          if (!controller.isCameraInitialized.value) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '카메라를 준비하고 있습니다...',
                    style: Typo.bodyMd(context, color: colors.gray900),
                  ),
                ],
              ),
            );
          }

          return Stack(
            children: [
              _buildCameraPreview(),
              _buildOverlay(context, colors),
              if (controller.showInstructions.value)
                _buildInstructions(context, colors),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildCameraPreview() {
    return Positioned.fill(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: controller.cameraController!.value.previewSize!.height,
          height: controller.cameraController!.value.previewSize!.width,
          child: CameraPreview(controller.cameraController!),
        ),
      ),
    );
  }

  Widget _buildOverlay(BuildContext context, ThemeColors colors) {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.6),
        child: Center(
          child: SvgPicture.asset(
            'assets/icons/face_registration_overlay.svg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildInstructions(BuildContext context, ThemeColors colors) {
    return Positioned.fill(
      child: Center(
        child: Text(
          '얼굴을 중앙에 맞춰 주세요!',
          style: Typo.headlineSub(context, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      )
    );
  }
}
