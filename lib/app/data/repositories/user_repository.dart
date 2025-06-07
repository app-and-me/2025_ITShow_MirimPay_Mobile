import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mirim_pay/app/data/models/user_model.dart';
import 'package:mirim_pay/util/service/auth_service.dart';
import 'package:http/http.dart' as http;

abstract class UserRepository {
  Future<User?> getCurrentUser();
  Future<void> logout();
  Future<bool> hasNewNotifications();
}

class UserRepositoryImpl implements UserRepository {
  @override
  Future<User?> getCurrentUser() async {
    try {
      final currentUser = auth.currentUser;

      if (currentUser != null) {
        final baseUrl = dotenv.env['BASE_URL'];
      
        final response = await http.get(
          Uri.parse('$baseUrl/users/${currentUser.id}'),
          headers: {
            'Content-Type': 'application/json',
          },
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
    return false;
  }
}
