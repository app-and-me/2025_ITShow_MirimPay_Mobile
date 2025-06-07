import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mirim_pay/util/service/auth_service.dart';
import '../models/user_model.dart';

class ApiService {
  static final String baseUrl = dotenv.env['BASE_URL'] ?? '';

  Future<User> getUserInfo() async {
    try {
      final currentUser = auth.currentUser;
      if (currentUser == null) {
        throw Exception('User not authenticated');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/users/${currentUser.id}'),
      );
      
      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load user info: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }
  
  Future<List<dynamic>> getPaymentHistory() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/${auth.currentUser?.id}/payment/history'),
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception('Failed to load payment history: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }
  
  Future<List<dynamic>> getCardInfo() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/cards'),
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception('Failed to load card info: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }
  
  Future<bool> registerFacePayment(String base64Image) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/face-payments/register'),
        body: jsonEncode({'face_image': base64Image}),
      );
      
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      throw Exception('Failed to register face payment: $e');
    }
  }

}