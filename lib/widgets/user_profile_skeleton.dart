import 'package:flutter/material.dart';
import 'skeleton_loader.dart';

class UserProfileSkeleton extends StatelessWidget {
  const UserProfileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: const Row(
        children: [
          SkeletonLoader(
            height: 60,
            width: 60,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonLoader(height: 20, width: 120),
                SizedBox(height: 8),
                SkeletonLoader(height: 16, width: 80),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
