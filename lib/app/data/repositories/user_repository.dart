import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mirim_pay/app/data/models/user_model.dart';
import 'package:mirim_pay/util/constants/app_constants.dart';
import 'package:mirim_pay/util/service/auth_service.dart';
import 'package:http/http.dart' as http;

abstract class UserRepository {
  Future<User?> getCurrentUser();
  Future<void> logout();
  Future<bool> hasNewNotifications();
  Future<bool> verifyCurrentPin(String pin);
  Future<bool> updatePin(String currentPin, String newPin);
}

class UserRepositoryImpl implements UserRepository {
  @override
  Future<User?> getCurrentUser() async {
    try {
      final currentUser = auth.currentUser;

      if (currentUser != null) {
        final baseUrl = dotenv.env['BASE_URL'];
      
        final response = await http.get(
          Uri.parse('$baseUrl/users/me'),
          headers: await AppConstants.getHeaders(),
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonData = json.decode(response.body);
          return User.fromJson(jsonData);
        } else {
          throw Exception('Failed to load user: ${response.statusCode}');
        }
      }

      return null;
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }

  @override
  Future<void> logout() async {
    await auth.logOut();
  }

  @override
  Future<bool> hasNewNotifications() async {
    try {
      final baseUrl = dotenv.env['BASE_URL'];
      
      final response = await http.get(
        Uri.parse('$baseUrl/alert/unread/count'),
        headers: await AppConstants.getHeaders(),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data > 0;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> verifyCurrentPin(String pin) async {
    try {
      final baseUrl = dotenv.env['BASE_URL'];
      
      final response = await http.get(
        Uri.parse('$baseUrl/users/verify/pin/$pin'),
        headers: await AppConstants.getHeaders(),
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> updatePin(String currentPin, String newPin) async {
    try {
      final baseUrl = dotenv.env['BASE_URL'];
      
      final response = await http.put(
        Uri.parse('$baseUrl/users/pin'),
        headers: await AppConstants.getHeaders(),
        body: json.encode({
          'currentPin': currentPin,
          'newPin': newPin,
        }),
      );
      
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
