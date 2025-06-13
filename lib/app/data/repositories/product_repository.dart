import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mirim_pay/pages/main/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:mirim_pay/util/constants/app_constants.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> getProducts();
}

class ProductRepositoryImpl implements ProductRepository {
  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final baseUrl = dotenv.env['BASE_URL'];
      final response = await http.get(
        Uri.parse('$baseUrl/products/'),
        headers: await AppConstants.getHeaders(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }
}