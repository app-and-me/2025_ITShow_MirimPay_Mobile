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
    final colors = ThemeColors.of(context);

    return Stack(
      children: [
        Positioned(
          child: SafeArea(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
              decoration: ShapeDecoration(
                color: colors.gray50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60),
                  side: BorderSide(color: colors.gray300, width: 0.5),
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
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildNavItem(
                    iconPath: 'assets/icons/pay.svg',
                    index: 0,
                    colors: colors,
                  ),
                  _buildNavItem(
                    iconPath: 'assets/icons/product.svg',
                    index: 1,
                    colors: colors,
                  ),
                  _buildNavItem(
                    iconPath: 'assets/icons/contact_us.svg',
                    index: 2,
                    colors: colors,
                  ),
                  _buildNavItem(
                    iconPath: 'assets/icons/me.svg',
                    index: 3,
                    colors: colors,
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
    required int index,
    required ThemeColors colors,
  }) {
    final isSelected = widget.currentIndex == index;
    return GestureDetector(
      onTap: () => widget.onTap(index),
      child: Padding(
          padding: const EdgeInsets.only(top: 18),
          child: Column(
            children: [
              SvgPicture.asset(iconPath,
                  colorFilter: ColorFilter.mode(
                    isSelected ? colors.primary : colors.gray400,
                    BlendMode.srcIn,
                  ),
                  height: 24.0,
                  width: 24.0),
            ],
          )),
    );
  }
}
