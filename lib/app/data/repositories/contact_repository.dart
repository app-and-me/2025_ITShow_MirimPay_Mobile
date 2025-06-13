import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mirim_pay/pages/main/models/question_model.dart';
import 'package:mirim_pay/util/constants/app_constants.dart';
import 'package:http/http.dart' as http;

abstract class ContactRepository {
  Future<List<QuestionModel>> getQuestions();
  Future<bool> submitQuestion(String category, String content);
  List<String> getCategories();
}

class ContactRepositoryImpl implements ContactRepository {
  @override
  Future<List<QuestionModel>> getQuestions() async {
    try {
      final baseUrl = dotenv.env['BASE_URL'];
      
      final response = await http.get(
        Uri.parse('$baseUrl/contact-us?status=completed'),
        headers: await AppConstants.getHeaders(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => QuestionModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load question: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }

  @override
  Future<bool> submitQuestion(String category, String title) async {
    try {
      final baseUrl = dotenv.env['BASE_URL'];
      
      final response = await http.post(
        Uri.parse('$baseUrl/contact-us'),
        headers: await AppConstants.getHeaders(),
        body: jsonEncode({
          'category': category,
          'title': title,
        }),
      );

      return response.statusCode == 201;
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }

  @override
  List<String> getCategories() {
    return ['재고', '입고', '품절', '운영', '그 외'];
  }
}
