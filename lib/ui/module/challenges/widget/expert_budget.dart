import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/ui/module/dashboard/widget/custom_fire_progress.dart';
import 'package:nutrogen/utils/helper.dart';

class ExpertBudgetWidget extends StatelessWidget {
  const ExpertBudgetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        15.verticalSpace,
        Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: AppColors.darkMidnightBlue,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 58.w,
                    height: 58.w,
                    decoration: BoxDecoration(
                      color: AppColors.blueberry,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          loc.lvl,
                          style: theme.primaryTextTheme.labelLarge
                              ?.copyWith(color: AppColors.cultured),
                        ),
                        Text(
                          '3',
                          style: theme.primaryTextTheme.displayMedium?.copyWith(
                            color: AppColors.cultured,
                            fontSize: 28.sp,
                            height: 0.8,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  15.horizontalSpace,
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.goldenPoppy,
                            ),
                            child: SvgPicture.asset(
                              width: 10,
                              AppAssets.svgStar,
                              colorFilter: const ColorFilter.mode(
                                AppColors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          5.horizontalSpace,
                          Text(
                            '400 Pts',
                            style: theme.textTheme.displaySmall
                                ?.copyWith(color: AppColors.white),
                          ),
                        ],
                      ),
                      5.verticalSpace,
                      Text(
                        'Expert badge',
                        style: theme.textTheme.bodySmall
                            ?.copyWith(color: AppColors.white),
                      ),
                    ],
                  ),
                  100.horizontalSpace,
                  SvgPicture.asset(AppAssets.award),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomFireProgress(
                    progress: 0.8,
                    child: (color) => Stack(
                      alignment: Alignment.center,
                      children: [
                        SvgPicture.asset(AppAssets.svgHexagon),
                      ],
                    ),
                  ),
                  10.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '40 Pts until next level',
                        style: theme.primaryTextTheme.labelLarge,
                      ),
                      120.horizontalSpace,
                      Text(
                        'Top points:',
                        style: theme.primaryTextTheme.labelLarge,
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.goldenPoppy,
                        ),
                        child: SvgPicture.asset(
                          width: 10,
                          AppAssets.svgStar,
                          colorFilter: const ColorFilter.mode(
                            AppColors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      Text(
                        '2314',
                        style: theme.primaryTextTheme.labelLarge,
                      ),
                    ],
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
