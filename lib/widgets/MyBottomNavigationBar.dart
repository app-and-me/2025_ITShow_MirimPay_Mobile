import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mirim_pay/util/style/colors.dart';

class MyBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const MyBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  // ignore: library_private_types_in_public_api
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final gray = Gray.of(context);
    final colors = PrimaryColors.of(context);

    return Stack(
      children: [
        Positioned(
          child: SafeArea(
            child: Container(
              margin: const EdgeInsets.all(16.0),
              decoration: ShapeDecoration(
                color: const Color(0xFFFEFFFE),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x19000000),
                    blurRadius: 3,
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 3,
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                  )
                ],
              ),
              height: 75,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(
                    iconPath: 'assets/icons/pay.svg',
                    text: '결제',
                    index: 0,
                    colors: colors,
                    gray: gray,
                  ),
                  _buildNavItem(
                    iconPath: 'assets/icons/product.svg',
                    text: '상품',
                    index: 1,
                    colors: colors,
                    gray: gray,
                  ),
                  _buildNavItem(
                    iconPath: 'assets/icons/contact_us.svg',
                    text: '문의',
                    index: 2,
                    colors: colors,
                    gray: gray,
                  ),
                  _buildNavItem(
                    iconPath: 'assets/icons/me.svg',
                    text: '나',
                    index: 3,
                    colors: colors,
                    gray: gray,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildNavItem({
    required String iconPath,
    required String text,
    required int index,
    required PrimaryColors colors,
    required Gray gray,
  }) {
    final isSelected = widget.currentIndex == index;
    return GestureDetector(
      onTap: () => widget.onTap(index),
      child: Padding(
          padding: const EdgeInsets.only(top: 14.0, bottom: 18.0),
          child: Column(
            children: [
              SvgPicture.asset(iconPath,
                  color: isSelected ? colors.primary : gray.gray400,
                  height: 24.0,
                  width: 24.0),
              const SizedBox(height: 2.0),
              Text(
                text,
                style: TextStyle(
                  color: isSelected ? colors.primary : gray.gray400,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  height: 1.40,
                  letterSpacing: -0.24,
                ),
              ),
            ],
          )),
    );
  }
}
