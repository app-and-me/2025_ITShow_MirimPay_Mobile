import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mirim_pay/util/service/auth_service.dart';
import 'package:http/http.dart' as http;

abstract class AuthRepository {
  Future<void> login();
  Future<void> logout();
  bool get isLoggedIn;
}

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<void> login() async {
    await auth.logIn();
    if (auth.currentUser == null) {
      throw Exception("Login failed");
    }

    try {
      final baseUrl = dotenv.env['BASE_URL'];
      
      final response = await http.get(
        Uri.parse('$baseUrl/users/${auth.currentUser?.id}'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      
      if (response.statusCode == 404) {
        await http.post(
          Uri.parse('$baseUrl/users/'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'id': int.parse(auth.currentUser?.id ?? '0'),
            'nickname': '${auth.currentUser?.nickname}',
          }),
        );
      } else {
        throw Exception('Failed to load user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }

  @override
  Future<void> logout() async {
    await auth.logOut();
  }

  @override
  bool get isLoggedIn => auth.currentUser != null;
}
