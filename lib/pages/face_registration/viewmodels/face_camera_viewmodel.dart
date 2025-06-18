import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:mirim_pay/app/data/repositories/face_registration_repository.dart';
import 'package:mirim_pay/util/constants/app_constants.dart';
import 'package:permission_handler/permission_handler.dart';

class FaceCameraViewModel extends GetxController {
  final FaceRegistrationRepository _repository = Get.find<FaceRegistrationRepository>();
  
  CameraController? cameraController;
  final RxBool isCameraInitialized = false.obs;
  final RxBool isProcessing = false.obs;
  final RxBool isCapturing = false.obs;
  final RxBool isLoading = false.obs;
  final RxBool showInstructions = true.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString loadingMessage = '얼굴을 등록하고 있습니다...'.obs;
  
  late FaceDetector faceDetector;
  
  @override
  void onInit() {
    super.onInit();
    _initializeCamera();
    _initializeFaceDetector();
    _hideInstructionsAfterDelay();
  }

  @override
  void onClose() {
    cameraController?.dispose();
    faceDetector.close();
    super.onClose();
  }

  void _hideInstructionsAfterDelay() {
    Future.delayed(const Duration(seconds: 3), () {
      showInstructions.value = false;
    });
  }

  Future<void> _initializeCamera() async {
    try {      
      var cameraPermission = await Permission.camera.status;
      
      if (cameraPermission != PermissionStatus.granted) {
        cameraPermission = await Permission.camera.request();
      }
      
      if (cameraPermission == PermissionStatus.permanentlyDenied) {
        hasError.value = true;
        errorMessage.value = '카메라 권한이 영구적으로 거부되었습니다.\n설정에서 권한을 허용해주세요.';
        return;
      } else if (cameraPermission != PermissionStatus.granted) {
        hasError.value = true;
        errorMessage.value = '카메라 권한이 필요합니다.\n아래 버튼을 눌러 권한을 요청해주세요.';
        return;
      }
      
      final cameras = await availableCameras();
      
      if (cameras.isEmpty) {
        Get.snackbar('오류', '사용 가능한 카메라가 없습니다.');
        Get.back();
        return;
      }

      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );
      
      cameraController = CameraController(
        frontCamera,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await cameraController!.initialize();
      
      if (cameraController!.value.isInitialized) {
        await cameraController!.setFlashMode(FlashMode.off);
        
        isCameraInitialized.value = true;
        
        await cameraController!.startImageStream(_processCameraImage);
      } else {
        throw Exception('Camera controller not initialized properly');
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = '카메라를 초기화할 수 없습니다: ${e.toString()}';
      Get.snackbar('오류', '카메라를 초기화할 수 없습니다: ${e.toString()}');
      Get.back();
    }
  }

  void _initializeFaceDetector() {
    final options = FaceDetectorOptions(
      enableContours: true,
      enableLandmarks: true,
    );
    faceDetector = FaceDetector(options: options);
  }

  void _processCameraImage(CameraImage image) async {
    if (isProcessing.value || isCapturing.value) return;
    
    isProcessing.value = true;
    
    try {
      final inputImage = _inputImageFromCameraImage(image);
      if (inputImage == null) {
        isProcessing.value = false;
        return;
      }

      final faces = await faceDetector.processImage(inputImage);
      
      if (faces.isNotEmpty) {
        final face = faces.first;
        final boundingBox = face.boundingBox;
        
        if (_isFaceCentered(boundingBox, image.width, image.height)) {
          await _captureAndRegisterFace();
        }
      }
    } catch (_) {
    } finally {
      isProcessing.value = false;
    }
  }

  bool _isFaceCentered(Rect boundingBox, int imageWidth, int imageHeight) {
    final centerX = imageWidth / 2;
    final centerY = imageHeight / 2;
    
    final faceCenterX = boundingBox.left + boundingBox.width / 2;
    final faceCenterY = boundingBox.top + boundingBox.height / 2;
    
    const tolerance = 100.0;
    
    return (faceCenterX - centerX).abs() < tolerance &&
           (faceCenterY - centerY).abs() < tolerance &&
           boundingBox.width > 150 &&
           boundingBox.height > 200;
  }

  Future<void> _captureAndRegisterFace() async {
    if (isCapturing.value) return;
    
    isCapturing.value = true;
    
    try {
      // 카메라 이미지 스트림 정지
      await cameraController!.stopImageStream();
      
      // 플래시 끄기
      await cameraController!.setFlashMode(FlashMode.off);
      
      // 사진 촬영
      loadingMessage.value = '사진을 촬영하고 있습니다...';
      isLoading.value = true;
      
      final image = await cameraController!.takePicture();
      final bytes = await File(image.path).readAsBytes();
      final base64Image = base64Encode(bytes);
      
      // 얼굴 등록 처리
      loadingMessage.value = '얼굴을 등록하고 있습니다...';
      
      // 로딩 효과를 위한 최소 지연시간
      await Future.delayed(const Duration(milliseconds: 1500));
      
      final success = await _repository.registerFaceBase64(base64Image);
      
      if (success) {
        loadingMessage.value = '등록이 완료되었습니다!';
        await Future.delayed(const Duration(milliseconds: 800));
        Get.offNamed(AppRoutes.faceRegistrationSuccess);
      } else {
        isLoading.value = false;
        Get.snackbar('오류', '얼굴 등록에 실패했습니다.');
        // 이미지 스트림 재시작
        await cameraController!.startImageStream(_processCameraImage);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('오류', '사진 촬영에 실패했습니다.');
      // 이미지 스트림 재시작
      await cameraController!.startImageStream(_processCameraImage);
    } finally {
      await Future.delayed(const Duration(seconds: 1));
      isCapturing.value = false;
    }
  }

  InputImage? _inputImageFromCameraImage(CameraImage image) {
    final camera = cameraController!.description;
    final sensorOrientation = camera.sensorOrientation;
    
    InputImageRotation? rotation;
    if (Platform.isIOS) {
      rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    } else if (Platform.isAndroid) {
      var rotationCompensation = camera.lensDirection == CameraLensDirection.front
          ? (sensorOrientation + 90) % 360
          : (sensorOrientation - 90 + 360) % 360;
      rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
    }
    
    if (rotation == null) return null;

    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    if (format == null) return null;

    final plane = image.planes.first;
    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation,
        format: format,
        bytesPerRow: plane.bytesPerRow,
      ),
    );
  }

  void goBack() {
    Get.back();
  }

  void retryInitializeCamera() {
    hasError.value = false;
    errorMessage.value = '';
    isCameraInitialized.value = false;
    _initializeCamera();
  }

  Future<void> requestCameraPermission() async {
    final permission = await Permission.camera.request();
    
    if (permission == PermissionStatus.granted) {
      retryInitializeCamera();
    } else if (permission == PermissionStatus.permanentlyDenied) {
      hasError.value = true;
      errorMessage.value = '카메라 권한이 영구적으로 거부되었습니다.\n설정에서 권한을 허용해주세요.';
    } else {
      hasError.value = true;
      errorMessage.value = '카메라 권한이 필요합니다.';
    }
  }

  Future<void> openDeviceSettings() async {
    await openAppSettings();
  }
}
