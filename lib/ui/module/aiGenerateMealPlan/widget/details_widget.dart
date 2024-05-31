import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/res/app_routers.dart';
import 'package:nutrogen/utils/helper.dart';
import 'package:nutrogen/ui/common/circular_arch_progress_bar_widget.dart';

class DetailsWidget extends HookConsumerWidget {
  const DetailsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onSeeMore() {
      context.pushNamed(AppRouters.nutritionSummary);
    }

    void onFollowThisPlan() {}

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.verticalSpace,
            Center(
              child: Container(
                width: 267.w,
                height: 220.w,
                padding: EdgeInsets.symmetric(
                  horizontal: 15.w,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const CircularArchProgressBarWidget(
                      value: 75,
                      fillColor: AppColors.goldenPoppy,
                      backgroundColor: AppColors.cultured,
                    ),
                    Positioned(
                      top: 92.h,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '2332/2345',
                            style: theme.textTheme.displayMedium?.copyWith(
                              fontSize: 26.sp,
                            ),
                          ),
                          Text(
                            loc.dailyIntake,
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: AppColors.darkSilver,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: AppColors.darkMidnightBlue,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(AppAssets.svgCalorie),
                  14.horizontalSpace,
                  Expanded(
                    child: Text(
                      'This plan creates a 500-calorie deficit from your current intake, perfectly tailored to help you shed those pounds',
                      style: theme.primaryTextTheme.titleSmall,
                    ),
                  ),
                ],
              ),
            ),
            20.verticalSpace,
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loc.goodForPeopleAllergicFrom,
                    style: theme.textTheme.displaySmall,
                  ),
                  12.verticalSpace,
                  ListView.separated(
                    shrinkWrap: true,
                    primary: false,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) => Row(
                      children: [
                        Image.asset(
                          AppAssets.jpgBreakfast,
                          width: 54.w,
                          height: 54.w,
                        ),
                        10.horizontalSpace,
                        Text(
                          'Kiwi',
                          style: theme.textTheme.titleMedium,
                        ),
                      ],
                    ),
                    separatorBuilder: (context, index) => Divider(
                      color: AppColors.platinum,
                      thickness: 1.h,
                      height: 15.h,
                    ),
                    itemCount: 2,
                  ),
                ],
              ),
            ),
            20.verticalSpace,
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loc.nutrientFulfillmentPerDay,
                    style: theme.textTheme.displaySmall,
                  ),
                  16.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${loc.protein} - 23%',
                        style: theme.textTheme.titleSmall,
                      ),
                      Text(
                        '89g',
                        style: theme.textTheme.titleSmall,
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  LinearProgressIndicator(
                    backgroundColor: AppColors.cultured,
                    value: 1.0,
                    minHeight: 10.h,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.goldenPoppy,
                    ),
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  30.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${loc.carbohydrates} - 23%',
                        style: theme.textTheme.titleSmall,
                      ),
                      Text(
                        '88g',
                        style: theme.textTheme.titleSmall,
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  LinearProgressIndicator(
                    backgroundColor: AppColors.cultured,
                    value: 0.8,
                    minHeight: 10.h,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.blueberry,
                    ),
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  30.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${loc.fat} - 23%',
                        style: theme.textTheme.titleSmall,
                      ),
                      Text(
                        '60g',
                        style: theme.textTheme.titleSmall,
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  LinearProgressIndicator(
                    backgroundColor: AppColors.cultured,
                    value: 0.95,
                    minHeight: 10.h,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.goldenPoppy,
                    ),
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  Center(
                    child: TextButton(
                      onPressed: onSeeMore,
                      child: Text(
                        loc.nutritionSummary,
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: AppColors.darkMidnightBlue,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            40.verticalSpace,
            Text(
              loc.description,
              style: theme.textTheme.bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            8.verticalSpace,
            Text(
              'According to the National Institutes of Health, nearly half of all adults in the United States have high blood pressure. If left untreated, high blood pressure can put more stress on the According to the National Institutes of Health, nearly half of all adults in the United States have high blood pressure. If left untreated, high blood pressure can put more stress on the According to the National Institutes of Health, nearly half of all adults in the United States have high blood pressure. If left untreated, high blood pressure can put more stress on the ',
              style: theme.textTheme.bodyMedium,
            ),
            100.verticalSpace,
            Center(
              child: ElevatedButton(
                onPressed: onFollowThisPlan,
                child: Text(
                  loc.followThisPlan,
                  style: theme.primaryTextTheme.headlineSmall,
                ),
              ),
            ),
            40.verticalSpace,
          ],
        ),
      ),
    );
  }
}
