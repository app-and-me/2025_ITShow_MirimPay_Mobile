import 'package:flutter/material.dart';
import 'skeleton_loader.dart';

class CardSkeleton extends StatelessWidget {
  const CardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[100],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonLoader(height: 20, width: 80),
          SizedBox(height: 20),
          SkeletonLoader(height: 24, width: 200),
          SizedBox(height: 12),
          SkeletonLoader(height: 16, width: 120),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SkeletonLoader(height: 16, width: 60),
              SkeletonLoader(height: 16, width: 80),
            ],
          ),
        ],
      ),
    );
  }
}
