class CardWriteModel {
  final String id;
  final String cardNumber;
  final String expiration;
  final String cvc;
  final String password;
  final String birthDate;
  final DateTime createdAt;

  CardWriteModel({
    required this.id,
    required this.cardNumber,
    required this.expiration,
    required this.cvc,
    required this.password,
    required this.birthDate,
    required this.createdAt,
  });

  factory CardWriteModel.fromJson(Map<String, dynamic> json) {
    return CardWriteModel(
      id: json['id'] ?? '',
      cardNumber: json['cardNumber'] ?? '',
      expiration: json['expiration'] ?? '',
      cvc: json['cvc'] ?? '',
      password: json['password'] ?? '',
      birthDate: json['birthDate'] ?? '',
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cardNumber': cardNumber,
      'expiration': expiration,
      'cvc': cvc,
      'password': password,
      'birthDate': birthDate,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  String get maskedCardNumber {
    if (cardNumber.length < 4) return cardNumber;
    return '**** **** **** ${cardNumber.substring(cardNumber.length - 4)}';
  }

  bool get isValid {
    return cardNumber.isNotEmpty &&
        expiration.isNotEmpty &&
        cvc.isNotEmpty &&
        password.isNotEmpty &&
        birthDate.isNotEmpty;
  }
}
