class ProductModel {
  final String id;
  final String name;
  final int price;
  final int quantity;
  final String category;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      price: json['price'] ?? 0,
      quantity: json['quantity'] ?? 0,
      category: json['category'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'quantity': quantity,
      'category': category,
    };
  }

  bool get isOutOfStock => quantity == 0;

  String get stockText {
    if (isOutOfStock) {
      return '입고 예정';
    }
    return '재고 : $quantity개';
  }

  String get priceText {
    return '${price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    )}원';
  }
}