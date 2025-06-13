import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mirim_pay/pages/main/viewmodels/me_page_viewmodel.dart';
import 'package:mirim_pay/widgets/menu_list_item.dart';
import 'package:mirim_pay/widgets/user_profile.dart';
import 'package:mirim_pay/widgets/user_profile_skeleton.dart';
import 'package:mirim_pay/widgets/menu_item_skeleton.dart';
import 'package:mirim_pay/widgets/custom_divider.dart';
import 'package:mirim_pay/widgets/logout_button.dart';
import 'package:mirim_pay/util/constants/app_constants.dart';
import 'package:mirim_pay/util/style/colors.dart';
import 'package:mirim_pay/util/style/typography.dart';

class MePage extends GetView<MePageViewModel> {
  const MePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);

    return Scaffold(
      backgroundColor: colors.gray50,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          title: Text(
            AppStrings.myInfo, 
            style: Typo.headlineLg(context, color: colors.gray900)
          ),
          centerTitle: false,
          actions: [
            Obx(() => IconButton(
              icon: SvgPicture.asset(
                context.isDarkMode ? controller.alertIconPathDark : controller.alertIconPathLight,
              ),
              onPressed: controller.navigateToAlert,
            )),
          ],
          backgroundColor: colors.gray50,
          scrolledUnderElevation: 0,
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Column(
            children: [
              const SizedBox(height: 24),
              const UserProfileSkeleton(),
              const SizedBox(height: 20),
              const CustomDivider(),
              ...List.generate(4, (index) => const MenuItemSkeleton()),
              const CustomDivider(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: colors.gray200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          );
        }

        return Column(
          children: [
            const SizedBox(height: 24),
            UserProfile(
              userName: controller.userName,
            ),
            const SizedBox(height: 42),
            const CustomDivider(),
            ...controller.menuItems.asMap().entries.map((entry) {
              final index = entry.key;
              final menuItem = entry.value;
              return MenuListItem(
                title: menuItem.title,
                onTap: () => controller.onMenuItemTap(index),
              );
            }),
            const CustomDivider(),
            const SizedBox(height: 42),
            LogoutButton(
              onTap: controller.isLoading.value ? null : controller.logout,
            ),
          ],
        );
      }),
    );
  }
}

