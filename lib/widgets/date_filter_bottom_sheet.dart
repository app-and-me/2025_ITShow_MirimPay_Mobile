import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mirim_pay/util/style/colors.dart';
import 'package:mirim_pay/util/style/typography.dart';

class DateFilterBottomSheet extends StatelessWidget {
  final String currentFilter;
  final Function(String) onFilterSelected;
  
  const DateFilterBottomSheet({
    super.key, 
    required this.currentFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ThemeColors.of(context);
    
    final filters = ['오늘', '최근 7일', '최근 1개월'];
    
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: colors.gray50,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final filter = filters[index];
                final isSelected = filter == currentFilter;
                
                return InkWell(
                  onTap: () {
                    onFilterSelected(filter);
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          filter,
                          style: Typo.bodyMd(
                            context,
                            color: isSelected ? colors.gray900 : colors.gray700,
                          )
                        ),
                        if (isSelected)
                          SvgPicture.asset(
                            'assets/icons/check.svg',
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(
                              colors.gray900,
                              BlendMode.srcIn,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}