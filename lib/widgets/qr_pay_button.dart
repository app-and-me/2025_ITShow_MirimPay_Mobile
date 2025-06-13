import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:mirim_pay/util/style/colors.dart';
import 'package:mirim_pay/util/style/typography.dart';
import 'package:mirim_pay/app/data/models/card_model.dart' as card_model;

class QrPayButton extends StatelessWidget {
  final bool isDisabled;
  final card_model.Card card;
  final VoidCallback? onTap;

  const QrPayButton({
    super.key,
    this.isDisabled = false,
    required this.card,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);
    
    return GestureDetector(
      onTap: isDisabled
          ? null
          : () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return QrPaymentDialog(card: card);
                },
              );
            },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 12),
        decoration: BoxDecoration(
          color: colors.gray50,
          border: Border.all(
            color: isDisabled ? colors.primaryLight : colors.primary,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/pay.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                isDisabled ? colors.primaryLightActive : colors.primary,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'QR 결제',
              style: Typo.bodySm(
                context,
                color: isDisabled ? colors.primaryLightActive : colors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QrPaymentDialog extends StatelessWidget {
  final card_model.Card card;

  const QrPaymentDialog({
    super.key,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);
    
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        width: 340,
        padding: const EdgeInsets.only(bottom: 24, left: 28, right: 28, top: 28),
        decoration: BoxDecoration(
          color: colors.gray50,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 2,
              spreadRadius: 2,
              offset: const Offset(0, 0),
            ),
          ],
          border: Border.all(
            color: colors.gray300,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'QR 결제',
              style: Typo.headlineLg(context, color: colors.gray800),
            ),
            const SizedBox(height: 22),
            QrImageView(
              data: '{"billingKey" : "${card.billingKey}", "customerKey" : "${card.customerKey}"}',
              version: QrVersions.auto,
              backgroundColor: colors.gray900,
            ),
          ],
        ),
      ),
    );
  }
}
