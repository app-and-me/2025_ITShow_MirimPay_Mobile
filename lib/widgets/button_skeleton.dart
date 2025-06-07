import 'package:flutter/material.dart';
import 'package:mirim_pay/widgets/skeleton_loader.dart';

class ButtonSkeleton extends StatelessWidget {
  final double? width;
  final double height;
  final BorderRadius? borderRadius;

  const ButtonSkeleton({
    super.key,
    this.width,
    this.height = 40,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return SkeletonLoader(
      height: height,
      width: width,
      borderRadius: borderRadius ?? BorderRadius.circular(4),
    );
  }
}
