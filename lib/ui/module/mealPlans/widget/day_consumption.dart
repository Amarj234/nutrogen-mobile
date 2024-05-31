import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/res/app_routers.dart';
import 'package:nutrogen/ui/common/circular_arch_progress_bar_widget.dart';
import 'package:nutrogen/ui/module/dashboard/widget/caloris_widget.dart';
import 'package:nutrogen/utils/helper.dart';

class DayConsumption extends HookConsumerWidget {
  const DayConsumption({
    required this.protrin,
    required this.item,
    required this.kcalRemaining,
    required this.fat,
    required this.carbohydrade,
    super.key,
  });

  final String protrin;
  final double item;
  final String kcalRemaining;
  final String fat;
  final String carbohydrade;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: AppColors.floralWhite,
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
      height: 426.h,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 42.w,
            child: Divider(
              color: AppColors.platinum,
              thickness: 4.h,
            ),
          ),
          16.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                loc.mealplanconsumedtoday,
                style: theme.textTheme.headlineSmall,
              ),
              Text(
                '$item Items',
                style: theme.textTheme.titleSmall,
              ),
            ],
          ),
          10.verticalSpace,
          LinearProgressIndicator(
            backgroundColor: AppColors.cultured,
            value: item,
            minHeight: 15.h,
            valueColor: const AlwaysStoppedAnimation<Color>(
              AppColors.goldenPoppy,
            ),
            borderRadius: BorderRadius.circular(50.r),
          ),
          25.verticalSpace,
          Hero(
            tag: 'calories_tag',
            child: Container(
              width: 166.w,
              height: 140.w,
              padding: EdgeInsets.only(
                left: 15.w,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularArchProgressBarWidget(
                    value: item,
                    fillColor: AppColors.blueberry,
                    backgroundColor: AppColors.white,
                  ),
                  Positioned(
                    top: 45.h,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          kcalRemaining,
                          style: theme.textTheme.displayMedium
                              ?.copyWith(fontSize: 26.sp),
                        ),
                        Text(
                          loc.kcalRemaining,
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
          20.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CaloriesWidget(
                name: loc.protein,
                value: protrin,
                svg: AppAssets.svgProtein,
              ),
              CaloriesWidget(
                name: loc.carbohydrates,
                value: carbohydrade,
                svg: AppAssets.svgCarbohydrates,
              ),
              CaloriesWidget(
                name: loc.fat,
                value: '${fat}g',
                svg: AppAssets.svgFat,
              ),
            ],
          ),
          10.verticalSpace,
          TextButton(
            onPressed: () {
              context.pop();
              context.pushNamed(AppRouters.nutritionSummary);
            },
            child: Text(
              loc.nutritionSummary,
              style: theme.textTheme.titleSmall?.copyWith(
                color: AppColors.darkMidnightBlue,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          10.verticalSpace,
        ],
      ),
    );
  }
}
