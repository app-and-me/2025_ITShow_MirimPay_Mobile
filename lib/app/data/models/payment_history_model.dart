class PaymentHistory {
  final int id;
  final String orderId;
  final int amount;
  final String orderName;
  final String status;
  final String paymentMethod;
  final PaymentCard card;
  final DateTime createdAt;

  PaymentHistory({
    required this.id,
    required this.orderId,
    required this.amount,
    required this.orderName,
    required this.status,
    required this.paymentMethod,
    required this.card,
    required this.createdAt,
  });

  factory PaymentHistory.fromJson(Map<String, dynamic> json) {
    return PaymentHistory(
      id: json['id'],
      orderId: json['orderId'],
      amount: json['amount'],
      orderName: json['orderName'],
      status: json['status'],
      paymentMethod: json['paymentMethod'],
      card: PaymentCard.fromJson(json['card']),
      createdAt: DateTime.parse(json['createdAt']).toLocal(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderId': orderId,
      'amount': amount,
      'orderName': orderName,
      'status': status,
      'paymentMethod': paymentMethod,
      'card': card.toJson(),
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class PaymentCard {
  final String cardCompany;
  final String cardNumber;

  PaymentCard({
    required this.cardCompany,
    required this.cardNumber,
  });

  factory PaymentCard.fromJson(Map<String, dynamic> json) {
    return PaymentCard(
      cardCompany: json['cardCompany'],
      cardNumber: json['cardNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cardCompany': cardCompany,
      'cardNumber': cardNumber,
    };
  }
}
