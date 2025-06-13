import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:mirim_pay/app/data/models/payment_history_model.dart';
import 'package:mirim_pay/util/constants/app_constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymentHistoryRepository extends GetxService {
  Future<List<PaymentHistory>> getPaymentHistory() async {
    try {
      final baseUrl = dotenv.env['BASE_URL'];
      
      final response = await http.get(
        Uri.parse('$baseUrl/users/payment/history'),
        headers: await AppConstants.getHeaders(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => PaymentHistory.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load payment history: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }
}
