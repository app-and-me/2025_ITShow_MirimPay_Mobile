import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mirim_pay/util/style/colors.dart';
import 'package:mirim_pay/util/style/typography.dart';
import 'package:get/get.dart';
import 'package:mirim_pay/widgets/category_badge.dart';
import 'viewmodels/contactus_write_page_viewmodel.dart';

class ContactUsWritePage extends GetView<ContactUsWritePageViewModel> {
  const ContactUsWritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);

    return Scaffold(
      backgroundColor: colors.gray50,
      appBar: AppBar(
        backgroundColor: colors.gray50,
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/cancel.svg',
            colorFilter: ColorFilter.mode(
              colors.gray800,
              BlendMode.srcIn,
            ),
          ),
          onPressed: controller.goBack,
        ),
        actions: [
          Obx(() => controller.isSubmittingObs.value
              ? const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: SizedBox(
                    width: 40,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
              : GetBuilder<ContactUsWritePageViewModel>(
                  builder: (controller) => TextButton(
                    onPressed:
                        controller.canSubmit ? controller.submitContactUs : null,
                    child: Text(
                      '등록',
                      style: Typo.bodyMd(
                        context,
                        color: controller.canSubmit ? colors.gray900 : colors.gray400,
                      ),
                    ),
                  ),
                )),
        ],
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(
            height: 1,
            thickness: 1,
            color: colors.gray300,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '카테고리',
              style: Typo.bodyMd(context, color: colors.gray800),
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Obx(() => Row(
                    children: controller.categories.map((category) {
                      final isSelected =
                          controller.selectedCategoryObs.value == category;
                      return Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: CategoryBadge(
                          text: category,
                          isSelected: isSelected,
                          onTap: () => controller.selectCategory(category),
                        ),
                      );
                    }).toList(),
                  )),
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: TextFormField(
                controller: controller.contentController,
                style: Typo.bodyMd(context, color: colors.gray800),
                maxLines: null,
                cursorColor: colors.gray800,
                decoration: InputDecoration(
                  hintText: '내용을 입력해주세요',
                  hintStyle: Typo.bodyMd(context, color: colors.gray400),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
