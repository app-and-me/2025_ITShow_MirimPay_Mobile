import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:mirim_pay/util/constants/app_constants.dart';
import 'package:mirim_pay/util/service/auth_service.dart';
import 'package:http/http.dart' as http;

abstract class AuthRepository {
  Future<bool> login();
  Future<void> logout();
  bool get isLoggedIn;
}

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<bool> login() async {
    await auth.logIn();
    if (auth.currentUser == null) {
      throw Exception("Login failed");
    }

    try {
      final baseUrl = dotenv.env['BASE_URL'];
      
      final response = await http.get(
        Uri.parse('$baseUrl/users/exist/${auth.currentUser?.id}'),
        headers: await AppConstants.getHeaders(),
      );
      
      if (response.statusCode == 404) {
        return false;
      }
      
      return true;
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
