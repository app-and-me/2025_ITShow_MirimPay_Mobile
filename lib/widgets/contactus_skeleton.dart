import 'package:flutter/material.dart';
import 'package:mirim_pay/widgets/skeleton_ui.dart';

class ContactUsButtonSkeleton extends StatelessWidget {
  const ContactUsButtonSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(12.0),
      child: SkeletonLoader(
        width: 40,
        height: 20,
        borderRadius: 8,
      ),
    );
  }
}
