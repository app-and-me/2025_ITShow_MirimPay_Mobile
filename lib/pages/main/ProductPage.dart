import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mirim_pay/util/style/colors.dart';
import 'package:mirim_pay/util/style/typography.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int _selectedCategoryIndex = 0;
  final List<String> _categories = ['전체', '과자', '음료수', '빵', '우유', '냉동식품', '아이스크림'];
  final ScrollController _scrollController = ScrollController();
  bool _showDivider = false;

  final List<Map<String, dynamic>> _allProducts = [
    {
      'name': '티즐 오렌지맛',
      'price': '2,700원',
      'stock': 7,
      'category': '과자',
      'isOutOfStock': false,
    },
    {
      'name': '코카콜라 250ml',
      'price': '1,500원',
      'stock': 15,
      'category': '음료수',
      'isOutOfStock': false,
    },
    {
      'name': '초코소라빵',
      'price': '1,800원',
      'stock': 20,
      'category': '빵',
      'isOutOfStock': false,
    },
    {
      'name': '딸기우유 200ml',
      'price': '1,400원',
      'stock': 12,
      'category': '우유',
      'isOutOfStock': false,
    },
    {
      'name': '냉동 떡볶이',
      'price': '4,500원',
      'stock': 0,
      'category': '냉동식품',
      'isOutOfStock': true,
    },
    {
      'name': '메로나',
      'price': '1,200원',
      'stock': 9,
      'category': '아이스크림',
      'isOutOfStock': false,
    },
    {
      'name': '과자 세트',
      'price': '5,000원',
      'stock': 3,
      'category': '과자',
      'isOutOfStock': false,
    },
    {
      'name': '바닐라 아이스크림',
      'price': '2,000원',
      'stock': 5,
      'category': '아이스크림',
      'isOutOfStock': false,
    }
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    final shouldShowDivider = _scrollController.offset > 50;
    if (shouldShowDivider != _showDivider) {
      setState(() {
        _showDivider = shouldShowDivider;
      });
    }
  }

  List<Map<String, dynamic>> _getFilteredProducts() {
    final String selectedCategory = _categories[_selectedCategoryIndex];
    if (_selectedCategoryIndex == 0) { 
      return _allProducts;
    }
    return _allProducts.where((p) => p['category'] == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);
    final filteredProducts = _getFilteredProducts();

    return Scaffold(
      backgroundColor: colors.gray50,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          title: Text(
            '상품',
            style: Typo.headlineLg(context, color: colors.gray900)
          ),
          centerTitle: false,
          actions: [
            IconButton(
              icon: SvgPicture.asset('assets/icons/search.svg'),
              onPressed: () {
              },
            ),
          ],
          backgroundColor: colors.gray50,
          scrolledUnderElevation: 0,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          Container(
            height: 35,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                return CategoryBadge(
                  text: _categories[index],
                  isSelected: _selectedCategoryIndex == index,
                  onTap: () {
                    setState(() {
                      _selectedCategoryIndex = index;
                    });
                  },
                );
              },
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 0),
            height: 16,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: _showDivider ? colors.gray200 : Colors.transparent,
                  width: 1,
                ),
              ),
            ),
          ),
          Expanded(
            child: filteredProducts.isEmpty 
              ? Center(
                  child: Text(
                    '${_categories[_selectedCategoryIndex]} 상품이 없습니다',
                    style: Typo.bodyMd(context, color: colors.gray600),
                  ),
                )
              : GridView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(
                    left: 16, 
                    right: 16, 
                    top: 16, 
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
                      name: product['name'],
                      price: product['price'],
                      stock: product['stock'] > 0 ? '재고 : ${product['stock']}개' : null,
                      isOutOfStock: product['isOutOfStock'],
                    );
                  },
                ),
          ),
        ],
      ),
    );
  }
}

class CategoryBadge extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback? onTap;

  const CategoryBadge({
    super.key,
    required this.text,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? colors.gray800 : colors.gray50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.transparent : colors.gray300,
            width: isSelected ? 0.0 : 0.7,
          ),
        ),
        child: Text(
          text,
          style: Typo.caption(
            context,
            color: isSelected ? colors.gray100 : colors.gray800,
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String name;
  final String price;
  final String? stock;
  final bool isOutOfStock;

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    this.stock,
    this.isOutOfStock = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);
    final Color textColor = isOutOfStock ? colors.gray400 : colors.gray900;
    final Color stockColor = isOutOfStock ? colors.gray400 : colors.primary;

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
          bottomLeft: Radius.circular(4),
          bottomRight: Radius.circular(4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: colors.gray300,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(4),
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isOutOfStock || stock == null ? '입고 예정' : stock!,
                  style: Typo.caption(context, color: stockColor)
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  name,
                  style: Typo.bodySm(context, color: textColor)
                      .copyWith(fontWeight: FontWeight.w400),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: Typo.bodySm(context, color: textColor)
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
