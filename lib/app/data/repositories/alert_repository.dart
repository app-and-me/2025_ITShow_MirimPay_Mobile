import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../../pages/alert/models/alert_model.dart';

abstract class AlertRepository {
  Future<List<AlertModel>> getRecentAlerts();
  Future<void> markAsRead(int alertId);
}

class AlertRepositoryImpl implements AlertRepository {  
  @override
  Future<List<AlertModel>> getRecentAlerts() async {
    try {
      final baseUrl = dotenv.env['BASE_URL'];
      
      final response = await http.get(
        Uri.parse('$baseUrl/alert'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => AlertModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load alerts: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }

  @override
  Future<void> markAsRead(int alertId) async {
    await Future.delayed(const Duration(milliseconds: 200));
  }
}