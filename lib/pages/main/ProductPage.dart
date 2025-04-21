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
  final List<String> _categories = ['과자', '음료수', '빵', '우유', '냉동식품', '아이스크림'];

  @override
  Widget build(BuildContext context) {
    final gray = Gray.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          title: Text(
            '상품',
            style: Typo.headlineLg(context, color: gray.gray900)
          ),
          centerTitle: false,
          actions: [
            IconButton(
              icon: SvgPicture.asset('assets/icons/search.svg'),
              onPressed: () {
              },
            ),
          ],
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
        ),
      ),
      body: Column(
        children: [
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
          
          Expanded(
            child: GridView.builder(
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
              itemCount: 6,
              itemBuilder: (context, index) {
                bool isOutOfStock = index == 4;
                
                return ProductCard(
                  name: '티즐 오렌지맛',
                  price: '2,700원',
                  stock: '재고 : 7개',
                  isOutOfStock: isOutOfStock,
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
    final gray = Gray.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? gray.gray50 : gray.gray50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? gray.gray300 : gray.gray300,
          ),
        ),
        child: Text(
          text,
          style: Typo.caption(
            context,
            color: gray.gray800,
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
    final gray = Gray.of(context);
    final primary = PrimaryColors.of(context);
    final Color textColor = isOutOfStock ? gray.gray500 : Colors.black;
    final Color stockColor = isOutOfStock ? gray.gray500 : primary.primary;

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
              color: isOutOfStock ? Colors.grey.shade300.withOpacity(0.8) : Colors.grey.shade300,
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
                  style: isOutOfStock ? 
                    TextStyle(
                      color: gray.gray500,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      height: 1.40,
                      letterSpacing: -0.24,
                    ) : 
                    Typo.caption(context, color: stockColor),
                ),
                const SizedBox(height: 2),
                Text(
                  name,
                  style: Typo.bodySm(context, color: textColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: Typo.bodySm(context, color: textColor).copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
