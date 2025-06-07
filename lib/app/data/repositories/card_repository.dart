import 'package:mirim_pay/app/data/models/card_model.dart';

abstract class CardRepository {
  Future<List<Card>> getUserCards();
  Future<void> addCard(Card card);
  Future<void> removeCard(int cardId);
  Future<void> setMainCard(int cardId);
}

class CardRepositoryImpl implements CardRepository {
  @override
  Future<List<Card>> getUserCards() async {
    await Future.delayed(const Duration(milliseconds: 500));

    // TODO: API 요청
    return [
      Card(id: 1, name: '토스카드', imageUrl: 'https://example.com/tos_card.png', number: '1234-****-****-1234', isMainCard: true),
      Card(id: 2, name: '카카오카드', imageUrl: 'https://example.com/kakao_card.png', number: '5678-****-****-5678', isMainCard: false),
    ];
  }

  @override
  Future<void> addCard(Card card) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<void> removeCard(int cardId) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<void> setMainCard(int cardId) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
