import 'package:flutter/material.dart';
import 'package:mirim_pay/util/style/colors.dart';
import 'package:mirim_pay/widgets/skeleton_ui.dart';

class CardInfoSkeletonItem extends StatelessWidget {
  const CardInfoSkeletonItem({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);
    
    return SizedBox(
      height: 165,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 17),
        decoration: BoxDecoration(
          color: colors.gray50,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Padding(
          padding: EdgeInsets.all(24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonLoader(
                width: 74,
                height: 117,
                borderRadius: 10,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SkeletonLoader(
                          width: 80,
                          height: 20,
                          borderRadius: 4,
                        ),
                        SkeletonLoader(
                          width: 24,
                          height: 24,
                          borderRadius: 12,
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    SkeletonLoader(
                      width: 120,
                      height: 16,
                      borderRadius: 4,
                    ),
                    SizedBox(height: 8),
                    SkeletonLoader(
                      width: 100,
                      height: 16,
                      borderRadius: 4,
                    ),
                    SizedBox(height: 8),
                    SkeletonLoader(
                      width: 90,
                      height: 16,
                      borderRadius: 4,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardInfoSkeleton extends StatelessWidget {
  const CardInfoSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 4),
      itemCount: 3,
      itemBuilder: (context, index) {
        return const CardInfoSkeletonItem();
      },
    );
  }
}
