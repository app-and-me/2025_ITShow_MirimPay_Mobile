class ProductModel {
  final String name;
  final String price;
  final int stock;
  final String category;
  final bool isOutOfStock;

  ProductModel({
    required this.name,
    required this.price,
    required this.stock,
    required this.category,
    required this.isOutOfStock,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'] ?? '',
      price: json['price'] ?? '',
      stock: json['stock'] ?? 0,
      category: json['category'] ?? '',
      isOutOfStock: json['isOutOfStock'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'stock': stock,
      'category': category,
      'isOutOfStock': isOutOfStock,
    };
  }

  String get stockText {
    if (isOutOfStock || stock == 0) {
      return '입고 예정';
    }
    return '재고 : $stock개';
  }
}