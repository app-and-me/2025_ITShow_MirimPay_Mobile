import 'package:mirim_pay/pages/pay/models/card_write_model.dart';

abstract class CardWriteRepository {
  Future<bool> saveCard(CardWriteModel card);
  Future<bool> validateCard(CardWriteModel card);
}

class CardWriteRepositoryImpl implements CardWriteRepository {
  @override
  Future<bool> saveCard(CardWriteModel card) async {
    // TODO: API 요청
    await Future.delayed(const Duration(milliseconds: 1500));
    return true;
  }

  @override
  Future<bool> validateCard(CardWriteModel card) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return card.isValid;
  }
}
