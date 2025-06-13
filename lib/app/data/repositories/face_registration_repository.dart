import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mirim_pay/util/constants/app_constants.dart';

abstract class FaceRegistrationRepository {
  Future<bool> registerFaceBase64(String faceImage);
}

class FaceRegistrationRepositoryImpl implements FaceRegistrationRepository {
  @override
  Future<bool> registerFaceBase64(String faceImage) async {
    try {
      final baseUrl = dotenv.env['BASE_URL'];
      
      final response = await http.post(
        Uri.parse('$baseUrl/users/face/base64'),
        headers: await AppConstants.getHeaders(),
        body: jsonEncode({
          'faceImage': faceImage,
        }),
      );

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      throw Exception('Failed to register face: $e');
    }
  }
}
