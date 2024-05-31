import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/data/model/meal_list_model.dart';
import 'package:nutrogen/data/model/meal_plan_model.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/res/app_routers.dart';
import 'package:nutrogen/ui/common/circular_arch_progress_bar_widget.dart';
import 'package:nutrogen/ui/common/image_widget.dart';
import 'package:nutrogen/ui/module/mealPlanDetailsOverview/widget/meal_details_widget.dart';
import 'package:nutrogen/ui/module/mealPlanDetailsOverview/widget/review_widget.dart';
import 'package:nutrogen/utils/helper.dart';

class OverviewWidget extends HookConsumerWidget {
  const OverviewWidget({required this.approveMealListREntity, super.key});
  final MealPlanR? approveMealListREntity;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Food> foodList = [Food(), Food(), Food(), Food()];

    for (var meal
        in (approveMealListREntity?.mealPlanMeta ?? <MealPlanMeta>[])) {
      int mealTypeInt = meal.mealName == '2' ||
              meal.mealName?.toLowerCase() == loc.lunch.toLowerCase()
          ? 1
          : meal.mealName == '3' ||
                  meal.mealName?.toLowerCase() == loc.snacks.toLowerCase()
              ? 2
              : meal.mealName == '4' ||
                      meal.mealName?.toLowerCase() == loc.dinner.toLowerCase()
                  ? 3
                  : 0;

      meal.recipe?.forEach((recipe) {
        recipe.ingredient?.forEach((element) {
          if (element.food != null) {
            foodList[mealTypeInt] =
                collectFood(foodList[mealTypeInt], element.food!);
          }
        });
      });

      meal.food?.forEach((food) {
        foodList[mealTypeInt] = collectFood(foodList[mealTypeInt], food);
      });
    }

    void onFollowThisPlan() async {
      await showModalBottomSheet(
        context: context,
        backgroundColor: AppColors.white,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        ),
        builder: (context) => const ConfirmFollowWidget(),
      );
    }

    void onSeeMore() {
      context.pushNamed(
        AppRouters.nutritionSummary,
        extra: foodList,
        queryParameters: {
          'limitProtein': '${approveMealListREntity?.limitProtein}',
          'limitCarbohydrates': '${approveMealListREntity?.limitCarbohydrates}',
          'limitFat': '${approveMealListREntity?.limitFat}',
        },
      );
    }

    Food foodContinent = Food();

    for (var element in foodList) {
      foodContinent = collectFood(foodContinent, element);
    }

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
                    CircularArchProgressBarWidget(
                      value: (((foodContinent.energyKcal ?? 0) / 1900) * 100),
                      fillColor: AppColors.goldenPoppy,
                      backgroundColor: AppColors.cultured,
                    ),
                    Positioned(
                      top: 92.h,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${foodContinent.energyKcal?.toStringAsFixed(0)}/1900',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => Align(
                      widthFactor: 0.6,
                      child: CircleAvatar(
                        radius: 12.r,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 10.r,
                          backgroundImage: const AssetImage(
                            AppAssets.jpgAvatar,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                10.horizontalSpace,
                Text(
                  '23,500',
                  style: theme.textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                6.horizontalSpace,
                Text(
                  'people currently using',
                  style: theme.textTheme.bodyLarge,
                ),
              ],
            ),
            34.verticalSpace,
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
                        ImageWidget(
                          '',
                          width: 54.w,
                          height: 54.w,
                        ),
                        10.horizontalSpace,
                        Text(
                          approveMealListREntity
                                  ?.excludeIngredients?[index].foodName ??
                              '',
                          style: theme.textTheme.titleMedium,
                        ),
                      ],
                    ),
                    separatorBuilder: (context, index) => Divider(
                      color: AppColors.platinum,
                      thickness: 1.h,
                      height: 15.h,
                    ),
                    itemCount:
                        approveMealListREntity?.excludeIngredients?.length ?? 0,
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
                    loc.macronutrientBreakupSummary,
                    style: theme.textTheme.displaySmall,
                  ),
                  16.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${loc.protein} - ${percent(maxValue: approveMealListREntity?.limitProtein?.toDouble(), value: foodContinent.proteinG)}%',
                        style: theme.textTheme.titleSmall,
                      ),
                      Text(
                        '${approveMealListREntity?.limitProtein}g',
                        style: theme.textTheme.titleSmall,
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  LinearProgressIndicator(
                    backgroundColor: AppColors.cultured,
                    value: (foodContinent.proteinG ?? 0) /
                        (approveMealListREntity?.limitProtein ?? 0),
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
                        '${loc.carbohydrates} - ${percent(maxValue: approveMealListREntity?.limitCarbohydrates?.toDouble(), value: foodContinent.carbohydrateG)}%',
                        style: theme.textTheme.titleSmall,
                      ),
                      Text(
                        '${approveMealListREntity?.limitCarbohydrates}g',
                        style: theme.textTheme.titleSmall,
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  LinearProgressIndicator(
                    backgroundColor: AppColors.cultured,
                    value: (foodContinent.carbohydrateG ?? 0) /
                        (approveMealListREntity?.limitProtein ?? 0),
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
                        '${loc.fat} - ${percent(maxValue: approveMealListREntity?.limitFat?.toDouble(), value: foodContinent.fatG)}%',
                        style: theme.textTheme.titleSmall,
                      ),
                      Text(
                        '${approveMealListREntity?.limitFat}g',
                        style: theme.textTheme.titleSmall,
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  LinearProgressIndicator(
                    backgroundColor: AppColors.cultured,
                    value: (foodContinent.fatG ?? 0) /
                        (approveMealListREntity?.limitFat ?? 0),
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
                        loc.seeMore,
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
              approveMealListREntity?.mealPlanNameDescription ?? '',
              style: theme.textTheme.bodyMedium,
            ),
            40.verticalSpace,
            Row(
              children: [
                Text(
                  loc.reviews,
                  style: theme.textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                SvgPicture.asset(
                  AppAssets.svgStar,
                  width: 24.w,
                  height: 24.w,
                  colorFilter: const ColorFilter.mode(
                    AppColors.goldenPoppy,
                    BlendMode.srcIn,
                  ),
                ),
                4.horizontalSpace,
                Text(
                  '4.9',
                  style: theme.textTheme.displaySmall,
                ),
              ],
            ),
            18.verticalSpace,
            SizedBox(
              height: 300.h,
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => 15.horizontalSpace,
                itemBuilder: (context, index) => const ReviewWidget(),
              ),
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
