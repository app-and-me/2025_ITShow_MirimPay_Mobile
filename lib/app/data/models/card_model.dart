class Card {
  final int id;
  final String cardCompany;
  final String cardNumber;
  final String cardNickname;
  final String customerKey;
  final String billingKey;
  bool isMainCard;
  final DateTime createdAt;

  Card({
    required this.id,
    required this.cardCompany,
    required this.cardNumber,
    required this.cardNickname,
    required this.customerKey,
    required this.billingKey,
    this.isMainCard = false,
    required this.createdAt,
  });

  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(
      id: json['id'],
      cardCompany: json['cardCompany'],
      cardNumber: json['cardNumber'],
      cardNickname: json['cardNickname'],
      customerKey: json['customerKey'],
      billingKey: json['billingKey'],
      isMainCard: json['isMainCard'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cardCompany': cardCompany,
      'cardNumber': cardNumber,
      'cardNickname': cardNickname,
      'isMainCard': isMainCard,
      'customerKey': customerKey,
      'billingKey': billingKey,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
