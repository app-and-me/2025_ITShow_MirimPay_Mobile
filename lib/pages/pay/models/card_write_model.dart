class CardWriteModel {
  final String id;
  final String cardNumber;
  final String expiryYear;
  final String expiryMonth;
  final String cardPassword;
  final String identityNumber;
  final String cvc;
  final String? cardNickname;
  final bool? isMainCard;
  final DateTime createdAt;

  CardWriteModel({
    required this.id,
    required this.cardNumber,
    required this.expiryYear,
    required this.expiryMonth,
    required this.cardPassword,
    required this.identityNumber,
    required this.cvc,
    this.cardNickname,
    this.isMainCard,
    required this.createdAt,
  });

  factory CardWriteModel.fromJson(Map<String, dynamic> json) {
    return CardWriteModel(
      id: json['id'] ?? '',
      cardNumber: json['cardNumber'] ?? '',
      expiryYear: json['expiryYear'] ?? '',
      expiryMonth: json['expiryMonth'] ?? '',
      cardPassword: json['cardPassword'] ?? '',
      identityNumber: json['identityNumber'] ?? '',
      cvc: json['cvc'] ?? '',
      cardNickname: json['cardNickname'],
      isMainCard: json['isMainCard'],
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cardNumber': cardNumber,
      'expiryYear': expiryYear,
      'expiryMonth': expiryMonth,
      'cardPassword': cardPassword,
      'identityNumber': identityNumber,
      'cardNickname': cardNickname,
      'cvc': cvc,
      'isMainCard': isMainCard,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  String get expiration => '$expiryMonth/$expiryYear';

  bool get isValid {
    return cardNumber.isNotEmpty &&
        expiryYear.isNotEmpty &&
        expiryMonth.isNotEmpty &&
        cardPassword.isNotEmpty &&
        identityNumber.isNotEmpty &&
        cvc.isNotEmpty;
  }
}
