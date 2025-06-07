import 'package:flutter/material.dart';
import 'skeleton_loader.dart';

class MenuItemSkeleton extends StatelessWidget {
  const MenuItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: const Row(
        children: [
          SkeletonLoader(
            height: 24,
            width: 24,
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          SizedBox(width: 16),
          Expanded(
            child: SkeletonLoader(height: 18, width: double.infinity),
          ),
          SizedBox(width: 16),
          SkeletonLoader(
            height: 16,
            width: 16,
            borderRadius: BorderRadius.all(Radius.circular(2)),
          ),
        ],
      ),
    );
  }
}
