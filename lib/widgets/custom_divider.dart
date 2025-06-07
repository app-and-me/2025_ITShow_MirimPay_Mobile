import 'package:flutter/material.dart';
import 'package:mirim_pay/util/style/colors.dart';

class CustomDivider extends StatelessWidget {
  final double height;
  final double? thickness;
  final EdgeInsetsGeometry? margin;

  const CustomDivider({
    super.key,
    this.height = 0,
    this.thickness = 2,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);
    
    return Column(
      children: [
        if (margin?.vertical != null) SizedBox(height: margin!.vertical),
        Container(
          width: double.infinity,
          height: thickness,
          color: colors.gray300,
        ),
        SizedBox(height: height),
      ],
    );
  }
}
