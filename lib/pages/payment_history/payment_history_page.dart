import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mirim_pay/pages/payment_history/viewmodels/payment_history_viewmodel.dart';
import 'package:mirim_pay/util/style/colors.dart';
import 'package:mirim_pay/util/style/typography.dart';
import 'package:mirim_pay/widgets/payment_history_item.dart';
import 'package:mirim_pay/widgets/payment_history_skeleton.dart';

class PaymentHistoryPage extends GetView<PaymentHistoryViewModel> {
  const PaymentHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);
    
    return Scaffold(
      backgroundColor: colors.gray50,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, colors),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const PaymentHistorySkeleton();
                }
                
                if (controller.todayPayments.isEmpty && controller.recentPayments.isEmpty) {
                  return Center(
                    child: Text(
                      '최근 결제 내역이 없어요',
                      style: Typo.headlineSub(context, color: colors.gray700),
                    ),
                  );
                }
                
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        _buildSection(
                          context: context,
                          title: '오늘',
                          payments: controller.todayPayments,
                          colors: colors,
                        ),
                        const SizedBox(height: 37),
                        _buildSection(
                          context: context,
                          title: '최근 7일',
                          payments: controller.recentPayments,
                          colors: colors,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ThemeColors colors) {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 21),
      child: Row(
        children: [
          GestureDetector(
            onTap: controller.goBack,
            child: SvgPicture.asset(
              'assets/icons/arrow_left.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                colors.gray900,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            '결제내역',
            style: Typo.headlineSub(context, color: colors.gray900),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required BuildContext context,
    required String title,
    required List payments,
    required ThemeColors colors,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Typo.bodyMd(context, color: colors.gray700),
        ),
        const SizedBox(height: 12),
        ...payments.map((payment) => Column(
          children: [
            PaymentHistoryItem(payment: payment),
            if (payment != payments.last) const SizedBox(height: 0),
          ],
        )),
      ],
    );
  }
}
