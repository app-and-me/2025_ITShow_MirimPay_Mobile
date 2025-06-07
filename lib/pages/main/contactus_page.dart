import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mirim_pay/pages/main/viewmodels/contactus_page_viewmodel.dart';
import 'package:mirim_pay/widgets/category_tab.dart';
import 'package:mirim_pay/widgets/date_filter_header.dart';
import 'package:mirim_pay/widgets/question_item.dart';
import 'package:mirim_pay/widgets/question_skeleton.dart';
import 'package:mirim_pay/widgets/date_filter_bottom_sheet.dart';
import 'package:mirim_pay/util/style/colors.dart';
import 'package:mirim_pay/util/style/typography.dart';

class ContactUsPage extends GetView<ContactUsPageViewModel> {
  const ContactUsPage({super.key});

  void _showDateFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => DateFilterBottomSheet(
        currentFilter: controller.selectedDateFilter.value,
        onFilterSelected: (String filter) {
          controller.selectDateFilter(filter);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);

    return Scaffold(
      backgroundColor: colors.gray50,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          title: Text(
            '문의',
            style: Typo.headlineLg(context, color: colors.gray900),
          ),
          centerTitle: false,
          actions: [
            IconButton(
              icon: SvgPicture.asset('assets/icons/search.svg',
                colorFilter: ColorFilter.mode(
                  colors.gray900,
                  BlendMode.srcIn,
                ),
              ),
              onPressed: controller.onSearch,
            ),
          ],
          backgroundColor: colors.gray50,
          scrolledUnderElevation: 0,
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 120.0),
        child: Container(
          width: 92,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: colors.primary, width: 1),
          ),
          child: FloatingActionButton.extended(
            backgroundColor: colors.gray50,
            elevation: 0,
            onPressed: controller.navigateToWrite,
            label: Text(
              '문의하기',
              style: Typo.bodySm(context, color: colors.primary)
                  .copyWith(fontWeight: FontWeight.w400),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Column(
        children: [
          const SizedBox(height: 24),
          Container(
            height: 35,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GetBuilder<ContactUsPageViewModel>(
              builder: (controller) => ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: controller.categories.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  return CategoryTab(
                    text: controller.categories[index],
                    isSelected:
                        controller.selectedCategoryIndex.value == index,
                    onTap: () => controller.selectCategory(index),
                  );
                },
              ),
            ),
          ),
          Obx(
            () => AnimatedContainer(
              duration: const Duration(milliseconds: 0),
              height: 16,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: controller.showDivider.value
                        ? colors.gray200
                        : Colors.transparent,
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return ListView.builder(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 150,
                    top: 16,
                  ),
                  itemCount: 5,
                  itemBuilder: (context, index) => const QuestionItemSkeleton(),
                );
              }

              return NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification is ScrollUpdateNotification) {
                    final shouldShowDivider =
                        notification.metrics.pixels > 10;
                    controller.updateDividerVisibility(shouldShowDivider);
                  }
                  return false;
                },
                child: ListView(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 150,
                    top: 16,
                  ),
                  children: [
                    DateFilterHeader(
                      title: controller.selectedDateFilter.value,
                      onTap: () => _showDateFilterBottomSheet(context),
                    ),
                    const SizedBox(height: 16),
                    if (controller.displayedQuestions.isEmpty) ...[
                      Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: colors.gray100,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '문의 내역이 없습니다',
                              style:
                                  Typo.bodyMd(context, color: colors.gray800),
                            ),
                          ],
                        ),
                      ),
                    ] else
                      ...controller.displayedQuestions.map(
                          (question) => QuestionItem(question: question)),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
