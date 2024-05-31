import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/utils/helper.dart';

class CholestrolWidget extends StatelessWidget {
  const CholestrolWidget({
    required this.title,
    required this.value,
    required this.goal,
    required this.progress,
    required this.activeColor,
    super.key,
  });

  final String title;
  final String value;
  final String goal;
  final int progress;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 124.w,
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.labelLarge
                ?.copyWith(color: AppColors.davysGrey),
          ),
          6.verticalSpace,
          Text(
            value,
            style: theme.textTheme.displayMedium,
          ),
          10.verticalSpace,
          Row(
            children: [
              Expanded(
                flex: progress,
                child: Container(
                  height: 7.h,
                  decoration: BoxDecoration(
                    color: activeColor,
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                ),
              ),
              3.horizontalSpace,
              Expanded(
                flex: 100 - progress,
                child: Container(
                  height: 7.h,
                  decoration: BoxDecoration(
                    color: AppColors.platinum,
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                ),
              ),
            ],
          ),
          10.verticalSpace,
          Text(
            '${loc.goal_} $goal',
            style: theme.textTheme.labelLarge
                ?.copyWith(color: AppColors.davysGrey),
          ),
        ],
      ),
    );
  }
}
