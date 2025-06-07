import 'package:flutter/material.dart';
import '../util/style/colors.dart';
import '../util/style/typography.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String price;
  final String stock;
  final bool isOutOfStock;

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.stock,
    required this.isOutOfStock,
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
          Stack(
            children: [
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colors.gray200,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Opacity(
                    opacity: isOutOfStock ? 0.4 : 1.0,
                    child: Image.asset(
                      'assets/images/$name.png',
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                            child: Icon(Icons.image, color: colors.gray600));
                      },
                    ),
                  ),
                ),
              ),
              if (isOutOfStock)
                SizedBox(
                  height: 120,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      '품절',
                      style:
                          Typo.bodyMd(context, color: colors.gray600).copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stock,
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
                Text(price, style: Typo.bodySm(context, color: textColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}