import 'package:mirim_pay/pages/main/models/product_model.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> getProducts();
}

class ProductRepositoryImpl implements ProductRepository {
  @override
  Future<List<ProductModel>> getProducts() async {
    await Future.delayed(const Duration(milliseconds: 500));
    // TODO: API 요청
    final mockData = [
      {
        'name': '구운 감자',
        'price': '1,000원',
        'stock': 0,
        'category': '과자',
        'isOutOfStock': true,
      },
      {
        'name': '치즈뿌린 치킨팝',
        'price': '1,000원',
        'stock': 2,
        'category': '과자',
        'isOutOfStock': false,
      },
      {
        'name': '포도알맹이',
        'price': '2,800원',
        'stock': 3,
        'category': '과자',
        'isOutOfStock': false,
      },
      {
        'name': '비쵸비 5개입',
        'price': '2,500원',
        'stock': 2,
        'category': '과자',
        'isOutOfStock': false,
      },
    ];
    
    return mockData.map((json) => ProductModel.fromJson(json)).toList();
  }
}