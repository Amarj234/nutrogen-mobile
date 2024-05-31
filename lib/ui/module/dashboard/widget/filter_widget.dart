import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/utils/helper.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({
    required this.title,
    required this.selectedFilter,
    required this.onTap,
    super.key,
  });

  final String title;
  final String selectedFilter;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50.r),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        decoration: BoxDecoration(
          color:
              selectedFilter == title ? AppColors.goldenPoppy : AppColors.white,
          borderRadius: BorderRadius.circular(50.r),
        ),
        child: Text(
          title,
          style: theme.textTheme.bodySmall?.copyWith(
            color: selectedFilter == title
                ? AppColors.white
                : AppColors.darkSilver,
            fontWeight:
                selectedFilter == title ? FontWeight.w500 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
