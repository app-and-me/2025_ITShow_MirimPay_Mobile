import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mirim_pay/util/style/typography.dart';
import 'package:mirim_pay/util/style/colors.dart';

class PayPage extends StatefulWidget {
  const PayPage({super.key});

  @override
  State<PayPage> createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);

    return Scaffold(
      backgroundColor: colors.gray50,
      appBar: AppBar(
        title: Text(
          '결제', 
          style: Typo.headlineLg(context, color: colors.gray900),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/alert_default.svg',
              color: colors.gray900,
            ),
            onPressed: () => Get.toNamed('/alert'),
          ),
        ],
        backgroundColor: colors.gray50,
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        child: Column(
          children: [
            CardSection(colors: colors),
            const SizedBox(height: 20),
            QrPayButton(context: context, colors: colors),
          ],
        ),
      ),
    );
  }
}

class CardSection extends StatelessWidget {
  final ThemeColors colors;

  const CardSection({
    super.key,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/icons/arrow_left.svg',
          width: 24,
          height: 24,
          color: colors.gray400,
        ),
        const SizedBox(width: 38),
        CardContainer(colors: colors),
        const SizedBox(width: 38),
        SvgPicture.asset(
          'assets/icons/arrow_right.svg',
          width: 24,
          height: 24,
          color: colors.gray400,
        ),
      ],
    );
  }
}

class CardContainer extends StatelessWidget {
  final ThemeColors colors;

  const CardContainer({
    super.key,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 219,
      height: 348,
      decoration: ShapeDecoration(
        color: colors.gray300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class QrPayButton extends StatelessWidget {
  final BuildContext context;
  final ThemeColors colors;

  const QrPayButton({
    super.key,
    required this.context,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 12),
      decoration: BoxDecoration(
        color: colors.gray50,
        border: Border.all(
          color: colors.primary,
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
            color: colors.primary,
          ),
          const SizedBox(width: 8),
          Text(
            'QR 결제',
            style: Typo.caption(context, color: colors.primary),
          ),
        ],
      ),
    );
  }
}