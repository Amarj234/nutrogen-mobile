import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nutrogen/res/app_colors.dart';

import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/utils/helper.dart';

class MealPlanWidget extends StatelessWidget {
  const MealPlanWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.asset(AppAssets.jpgPlan),
              ),
              Positioned(
                right: 8.w,
                top: 8.w,
                child: Container(
                  width: 140.w,
                  height: 38.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.antiFlashWhite,
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  child: Text(
                    '100% Alligned',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: AppColors.darkMidnightBlue,
                      fontFamily: AppAssets.fontPlusJakartaSans,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
          16.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              5.horizontalSpace,
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '30-Day High-Protein Breakfast Plan for Weight Loss',
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    4.verticalSpace,
                    Row(
                      children: [
                        Text(
                          '2345/2345 kcal',
                          style: theme.textTheme.titleSmall
                              ?.copyWith(color: AppColors.darkSilver),
                        ),
                        6.horizontalSpace,
                        Container(
                          width: 5.w,
                          height: 5.w,
                          decoration: const BoxDecoration(
                            color: AppColors.darkSilver,
                            shape: BoxShape.circle,
                          ),
                        ),
                        6.horizontalSpace,
                        Text(
                          'By Danielle DeAngelis',
                          style: theme.textTheme.titleSmall
                              ?.copyWith(color: AppColors.darkSilver),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              10.horizontalSpace,
              Row(
                children: [
                  SvgPicture.asset(AppAssets.svgStar),
                  4.horizontalSpace,
                  Text(
                    '4.9',
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              5.horizontalSpace,
            ],
          ),
          10.verticalSpace,
        ],
      ),
    );
  }
}
