import 'package:flutter/material.dart';
import 'skeleton_loader.dart';

class AlertItemSkeleton extends StatelessWidget {
  const AlertItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: const Row(
        children: [
          SkeletonLoader(
            height: 24,
            width: 24,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonLoader(height: 12, width: 40),
                SizedBox(height: 4),
                SkeletonLoader(height: 16, width: double.infinity),
              ],
            ),
          ),
          SizedBox(width: 16),
          SkeletonLoader(height: 12, width: 50),
        ],
      ),
    );
  }
}
