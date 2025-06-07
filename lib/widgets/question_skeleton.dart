import 'package:flutter/material.dart';
import 'skeleton_loader.dart';

class QuestionItemSkeleton extends StatelessWidget {
  const QuestionItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SkeletonLoader(height: 16, width: 60),
              Spacer(),
              SkeletonLoader(height: 12, width: 40),
            ],
          ),
          SizedBox(height: 8),
          SkeletonLoader(height: 18, width: double.infinity),
          SizedBox(height: 4),
          SkeletonLoader(height: 16, width: 200),
        ],
      ),
    );
  }
}
