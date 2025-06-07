import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mirim_pay/util/style/colors.dart';
import 'package:mirim_pay/util/style/typography.dart';
import 'package:mirim_pay/widgets/alert_item.dart';
import 'package:mirim_pay/widgets/alert_skeleton.dart';
import 'viewmodels/alert_page_viewmodel.dart';

class AlertPage extends GetView<AlertPageViewModel> {
  const AlertPage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeColors colors = ThemeColors.of(context);
    
    return Scaffold(
      backgroundColor: colors.gray50,
      appBar: AppBar(
        backgroundColor: colors.gray50,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/arrow_back.svg',
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              colors.gray900,
              BlendMode.srcIn,
            ),
          ),
          onPressed: controller.goBack,
        ),
        title: Text(
          '알림', 
          style: Typo.headlineSub(context, color: colors.gray900),
        ),
        centerTitle: false,
        titleSpacing: 0,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => controller.alertsObs.isNotEmpty 
            ? Padding(
                padding: const EdgeInsets.only(left: 16, top: 16, bottom: 12),
                child: Text(
                  '최근 7일',
                  style: Typo.caption(context, color: colors.gray800),
                ),
              )
            : const SizedBox.shrink()),
          Expanded(
            child: Obx(() {
              if (controller.isLoadingObs.value) {
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 5,
                  itemBuilder: (context, index) => const AlertItemSkeleton(),
                );
              }
              
              if (controller.alertsObs.isEmpty) {
                return Center(
                  child: Text(
                    '최근 도착한 알람이 없어요',
                    style: Typo.headlineSub(context, color: colors.gray700),
                  ),
                );
              }
              
              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: controller.alertsObs.length,
                itemBuilder: (context, index) {
                  final alert = controller.alertsObs[index];
                  return AlertItemWidget(
                    alert: alert,
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
