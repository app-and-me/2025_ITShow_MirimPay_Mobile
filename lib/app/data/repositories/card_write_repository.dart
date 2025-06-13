import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mirim_pay/pages/pay/models/card_write_model.dart';
import 'package:mirim_pay/util/constants/app_constants.dart';
import 'package:http/http.dart' as http;

abstract class CardWriteRepository {
  Future<bool> saveCard(CardWriteModel card);
}

class CardWriteRepositoryImpl implements CardWriteRepository {
  @override
  Future<bool> saveCard(CardWriteModel card) async {
    try {
      final baseUrl = dotenv.env['BASE_URL'];
      
      final response = await http.post(
        Uri.parse('$baseUrl/users/card'),
        headers: await AppConstants.getHeaders(),
        body: jsonEncode(card.toJson()..remove('id')..remove('createdAt')),
      );

      return response.statusCode == 201;
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }
}
