import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mirim_pay/util/style/colors.dart';
import 'package:mirim_pay/util/style/typography.dart';
import 'package:mirim_pay/widgets/category_badge.dart';
import 'package:mirim_pay/widgets/product_card.dart';
import 'package:mirim_pay/widgets/product_skeleton.dart';
import 'viewmodels/product_page_viewmodel.dart';

class ProductPage extends GetView<ProductPageViewModel> {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);

    return Scaffold(
      backgroundColor: colors.gray50,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Obx(() => AppBar(
          title: controller.isSearching.value
              ? TextField(
                  controller: controller.searchController,
                  onChanged: controller.onSearchChanged,
                  autofocus: true,
                  cursorColor: colors.gray50,
                  decoration: InputDecoration(
                    hintText: '상품 검색...',
                    hintStyle: Typo.bodyMd(context, color: colors.gray500),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: Typo.headlineLg(context, color: colors.gray900),
                )
              : Text('상품',
                  style: Typo.headlineLg(context, color: colors.gray900)),
          centerTitle: false,
          actions: [
            IconButton(
              icon: SvgPicture.asset(
                controller.isSearching.value ? 'assets/icons/cancel.svg' : 'assets/icons/search.svg',
                colorFilter: ColorFilter.mode(
                  colors.gray900,
                  BlendMode.srcIn,
                ),
              ),
              onPressed: controller.isSearching.value ? controller.clearSearch : controller.onSearch,
            ),
          ],
          backgroundColor: colors.gray50,
          scrolledUnderElevation: 0,
        )),
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          Container(
            height: 35,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Obx(
              () => ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: controller.categories.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  return CategoryBadge(
                    text: controller.categories[index],
                    isSelected:
                        controller.selectedCategoryIndex.value == index,
                    onTap: () => controller.selectCategory(index),
                  );
                },
              ),
            ),
          ),
          Obx(() => AnimatedContainer(
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
              )),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return GridView.builder(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 20,
                    bottom: 130,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: 6,
                  itemBuilder: (context, index) => const ProductCardSkeleton(),
                );
              }
              
              final filteredProducts = controller.filteredProducts;

              if (filteredProducts.isEmpty) {
                return Center(
                  child: Text(
                    controller.isSearching.value 
                        ? '검색 결과가 없습니다'
                        : '${controller.selectedCategory} 상품이 없습니다',
                    style: Typo.bodyMd(context, color: colors.gray600),
                  ),
                );
              }

              return GridView.builder(
                controller: controller.scrollController,
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 20,
                  bottom: 130,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return ProductCard(
                    name: product.name,
                    price: product.priceText,
                    stock: product.stockText,
                    isOutOfStock: product.isOutOfStock,
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
