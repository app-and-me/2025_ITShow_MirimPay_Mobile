import 'package:flutter/material.dart';
import 'package:mirim_pay/app/data/models/payment_history_model.dart';
import 'package:mirim_pay/util/style/colors.dart';
import 'package:mirim_pay/util/style/typography.dart';

class PaymentHistoryItem extends StatelessWidget {
  final PaymentHistory payment;

  const PaymentHistoryItem({
    super.key,
    required this.payment,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);
    
    String formatDate(DateTime date) {
      return '${date.month}.${date.day}';
    }
    
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: colors.gray50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
                children: [
                Text(
                  formatDate(payment.createdAt),
                  style: Typo.bodySm(context, color: colors.gray600),
                ),
                const SizedBox(width: 36),
                Text(
                  payment.orderName.length > 13
                    ? '${payment.orderName.substring(0, 13)}...'
                    : payment.orderName,
                  style: Typo.bodyMd(context, color: colors.gray800)
                    .copyWith(fontWeight: FontWeight.w400),
                ),
              ],
            ),
            Text(
              '- ${payment.amount.toString().replaceAllMapped(
                RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                (Match m) => '${m[1]},',
              )}원',
              style: Typo.bodyMd(context, color: colors.primary).copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
