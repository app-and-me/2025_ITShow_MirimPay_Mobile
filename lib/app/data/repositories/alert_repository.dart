import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mirim_pay/util/constants/app_constants.dart';

import '../../../pages/alert/models/alert_model.dart';

abstract class AlertRepository {
  Future<List<AlertModel>> getRecentAlerts();
  Future<void> markAsRead(int alertId);
  Future<int> getUnreadCount();
}

class AlertRepositoryImpl implements AlertRepository {
  @override
  Future<List<AlertModel>> getRecentAlerts() async {
    try {
      final baseUrl = dotenv.env['BASE_URL'];
      
      final response = await http.get(
        Uri.parse('$baseUrl/alert'),
        headers: await AppConstants.getHeaders(),
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
    try {
      final baseUrl = dotenv.env['BASE_URL'];
      
      final response = await http.patch(
        Uri.parse('$baseUrl/alert/$alertId/read'),
        headers: await AppConstants.getHeaders(),
      );
      
      if (response.statusCode != 200) {
        throw Exception('Failed to mark alert as read: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to mark alert as read: $e');
    }
  }

  @override
  Future<int> getUnreadCount() async {
    try {
      final baseUrl = dotenv.env['BASE_URL'];
      
      final response = await http.get(
        Uri.parse('$baseUrl/alert/unread/count'),
        headers: await AppConstants.getHeaders(),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        throw Exception('Failed to get unread count: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to get unread count: $e');
    }
  }
}