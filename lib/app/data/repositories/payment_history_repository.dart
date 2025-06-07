import 'package:get/get.dart';
import 'package:mirim_pay/app/data/models/payment_history_model.dart';

class PaymentHistoryRepository extends GetxService {
  Future<List<PaymentHistory>> getTodayPayments() async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return [
      PaymentHistory(
        id: '1',
        date: '2.2',
        productName: '상품명',
        amount: 0,
        createdAt: DateTime.now(),
      ),
      PaymentHistory(
        id: '2',
        date: '2.2',
        productName: '상품명',
        amount: 0,
        createdAt: DateTime.now(),
      ),
      PaymentHistory(
        id: '3',
        date: '2.2',
        productName: '상품명',
        amount: 0,
        createdAt: DateTime.now(),
      ),
    ];
  }

  Future<List<PaymentHistory>> getRecentPayments() async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return [
      PaymentHistory(
        id: '4',
        date: '2.2',
        productName: '상품명',
        amount: 0,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      PaymentHistory(
        id: '5',
        date: '2.2',
        productName: '상품명',
        amount: 0,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      PaymentHistory(
        id: '6',
        date: '2.2',
        productName: '상품명',
        amount: 0,
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
    ];
  }
}
