import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/utils/helper.dart';

class FilterDataWidget extends StatelessWidget {
  const FilterDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15.r),
          child: Image.asset(
            AppAssets.jpgTask,
            width: 256.w,
            height: 256.w,
          ),
        ),
        Positioned(
          right: 12.w,
          top: 12.h,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColors.antiFlashWhite,
              borderRadius: BorderRadius.circular(50.r),
            ),
            child: Text(
              'Task',
              style: theme.textTheme.labelLarge
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Positioned(
          left: 20.w,
          bottom: 20.h,
          child: Column(
            children: [
              Text(
                'Eat clean',
                style: theme.primaryTextTheme.bodyLarge,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(AppAssets.pngCoin),
                  2.horizontalSpace,
                  Text(
                    '234 points',
                    style: theme.primaryTextTheme.titleSmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
