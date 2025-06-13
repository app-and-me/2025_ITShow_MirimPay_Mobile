import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mirim_pay/app/data/models/card_model.dart';
import 'package:http/http.dart' as http;
import 'package:mirim_pay/util/constants/app_constants.dart';
abstract class CardRepository {
  Future<List<Card>> getUserCards();
  Future<void> removeCard(int cardId);
  Future<void> setMainCard(int cardId);
}

class CardRepositoryImpl implements CardRepository {
  @override
  Future<List<Card>> getUserCards() async {
    try {
      final baseUrl = dotenv.env['BASE_URL'];
      
      final response = await http.get(
        Uri.parse('$baseUrl/users/cards'),
        headers: await AppConstants.getHeaders(),
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Card.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load cards: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }

  @override
  Future<void> removeCard(int cardId) async {
    try {
      final baseUrl = dotenv.env['BASE_URL'];

      final response = await http.delete(
        Uri.parse('$baseUrl/users/cards/$cardId'),
        headers: await AppConstants.getHeaders(),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to remove card: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }

  @override
  Future<void> setMainCard(int cardId) async {
    try {
      final baseUrl = dotenv.env['BASE_URL'];

      final response = await http.post(
        Uri.parse('$baseUrl/users/cards/$cardId/main'),
        headers: await AppConstants.getHeaders(),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to set main card: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }
}
