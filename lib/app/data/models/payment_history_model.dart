class PaymentHistory {
  final String id;
  final String date;
  final String productName;
  final int amount;
  final DateTime createdAt;

  PaymentHistory({
    required this.id,
    required this.date,
    required this.productName,
    required this.amount,
    required this.createdAt,
  });

  factory PaymentHistory.fromJson(Map<String, dynamic> json) {
    return PaymentHistory(
      id: json['id'],
      date: json['date'],
      productName: json['product_name'],
      amount: json['amount'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'product_name': productName,
      'amount': amount,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
