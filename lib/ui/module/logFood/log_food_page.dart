import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/data/model/meal_list_model.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/res/app_routers.dart';
import 'package:nutrogen/ui/common/circular_arch_progress_bar_widget.dart';
import 'package:nutrogen/ui/common/state_view.dart';
import 'package:nutrogen/ui/module/dashboard/widget/caloris_widget.dart';
import 'package:nutrogen/ui/module/home/home_provider.dart';
import 'package:nutrogen/ui/module/logFood/log_food_provider.dart';
import 'package:nutrogen/ui/module/logFood/widget/diary_widget.dart';
import 'package:nutrogen/ui/module/logFood/widget/hydration_widget.dart';
import 'package:nutrogen/ui/module/logFood/widget/meal_type_sheet_widget.dart';
import 'package:nutrogen/utils/date_utils.dart';
import 'package:nutrogen/utils/helper.dart';
import 'package:nutrogen/utils/helper_extension.dart';
import 'package:nutrogen/utils/horizontal_date_picker.dart';

class LogFoodPage extends HookConsumerWidget {
  const LogFoodPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final labelList = useMemoized(
      () => [
        loc.breakfast,
        loc.lunch,
        loc.snacks,
        loc.dinner,
        loc.water,
      ],
    );

    void onAdd() {
      context.pushNamed(AppRouters.mealPlanLog);
    }

    void onAddMeal(String mealType) {
      context.pushNamed(
        AppRouters.addMeal,
        queryParameters: {
          'mealType': mealType,
          'mealDate': ref.read(selectedDateProvider).dateTimeToyyyyMMDD,
        },
      );
    }

    void onAddMealType() async {
      ref.read(bottomNavHideProvider.notifier).state = true;
      await showModalBottomSheet(
        context: context,
        backgroundColor: AppColors.white,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        ),
        builder: (context) => MealTypeSheetWidget(
          onTap: (type) {
            context.pop();
            onAddMeal(type);
          },
        ),
      );
      ref.read(bottomNavHideProvider.notifier).state = false;
    }

    void onDateSelect(DateTime date) {
      ref.read(selectedDateProvider.notifier).state = date;
    }

    final mealListData = ref.watch(mealListProvider);

    final foodContinent = useState(Food());

    mealListData.whenData((value) {
      foodContinent.value = Food();
      for (var meal in value) {
        if (meal.recipes != null) {
          meal.recipes?.ingredient?.forEach((element) {
            if (element.food != null) {
              foodContinent.value =
                  collectFood(foodContinent.value, element.food!);
            }
          });
        } else {
          if (meal.food != null) {
            foodContinent.value = collectFood(foodContinent.value, meal.food!);
          }
        }
      }
    });

    void onNutritionSummary() {
      final meals = mealListData.asData?.value;
      if (meals == null) return;

      List<Food> foodList = [Food(), Food(), Food(), Food()];

      for (var meal in meals) {
        int mealTypeInt =
            meal.mealType?.toLowerCase() == loc.dinner.toLowerCase()
                ? 3
                : meal.mealType?.toLowerCase() == loc.snacks.toLowerCase()
                    ? 2
                    : meal.mealType?.toLowerCase() == loc.lunch.toLowerCase()
                        ? 1
                        : 0;
        if (meal.recipes != null) {
          meal.recipes?.ingredient?.forEach((element) {
            if (element.food != null) {
              foodList[mealTypeInt] =
                  collectFood(foodList[mealTypeInt], element.food!);
            }
          });
        } else {
          if (meal.food != null) {
            foodList[mealTypeInt] =
                collectFood(foodList[mealTypeInt], meal.food!);
          }
        }
      }

      context.pushNamed(AppRouters.nutritionSummary, extra: foodList);
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: AppColors.white,
            height: ScreenUtil().statusBarHeight,
          ),
          Expanded(
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  floating: false,
                  pinned: false,
                  collapsedHeight: 115.h,
                  automaticallyImplyLeading: false,
                  expandedHeight: 115.h,
                  backgroundColor: AppColors.white,
                  flexibleSpace: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Center(
                            child: Text(
                              loc.diary,
                              style: theme.textTheme.bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(right: 10.w),
                              child: IconButton(
                                onPressed: onAdd,
                                padding: EdgeInsets.zero,
                                icon: SvgPicture.asset(
                                  AppAssets.svgPlusBg,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      DatePicker(
                        DateTime.now(),
                        initialSelectedDate: ref.watch(selectedDateProvider),
                        onDateChange: onDateSelect,
                      ),
                      15.verticalSpace,
                      Divider(
                        color: AppColors.brightGray,
                        thickness: 1.h,
                        height: 1.h,
                      ),
                    ],
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverAppBarDelegate(
                    minHeight: 65.h,
                    maxHeight: 0.h,
                    child: Stack(
                      children: [
                        Container(
                          height: 60.h,
                          color: AppColors.white,
                        ),
                        ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          scrollDirection: Axis.horizontal,
                          primary: false,
                          shrinkWrap: true,
                          itemCount: labelList.length,
                          itemBuilder: (context, index) => IntrinsicWidth(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                TextButton(
                                  onPressed: () => ref
                                      .read(selectedMealTypeProvider.notifier)
                                      .state = labelList[index],
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15.w,
                                    ),
                                  ),
                                  child: Text(
                                    labelList[index],
                                    style: ref.watch(
                                              selectedMealTypeProvider,
                                            ) ==
                                            labelList[index]
                                        ? theme.textTheme.headlineSmall
                                        : theme.textTheme.bodyMedium?.copyWith(
                                            color: AppColors.darkSilver,
                                          ),
                                  ),
                                ),
                                Visibility(
                                  visible: ref.watch(
                                        selectedMealTypeProvider,
                                      ) ==
                                      labelList[index],
                                  child: Container(
                                    height: 7.h,
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        50.r,
                                      ),
                                      color: AppColors.darkMidnightBlue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              body: Container(
                width: 1.sw,
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      40.verticalSpace,
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
                                value: (((foodContinent.value.energyKcal ?? 0) /
                                        1900) *
                                    100),
                                fillColor: AppColors.goldenPoppy,
                                backgroundColor: AppColors.white,
                              ),
                              Positioned(
                                top: 45.h,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '${(1900 - (foodContinent.value.energyKcal ?? 0)).round() <= 0 ? 0 : (1900 - (foodContinent.value.energyKcal ?? 0)).round()}',
                                      style: theme.textTheme.displayMedium
                                          ?.copyWith(fontSize: 26.sp),
                                    ),
                                    Text(
                                      loc.kcalRemaining,
                                      style:
                                          theme.textTheme.labelLarge?.copyWith(
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
                            value:
                                '${(foodContinent.value.proteinG ?? 0).round()}/75g',
                            svg: AppAssets.svgProtein,
                          ),
                          CaloriesWidget(
                            name: loc.carbohydrates,
                            value:
                                '${(foodContinent.value.carbohydrateG ?? 0).round()}/500g',
                            svg: AppAssets.svgCarbohydrates,
                          ),
                          CaloriesWidget(
                            name: loc.fat,
                            value:
                                '${(foodContinent.value.fatG ?? 0).round()}/70g',
                            svg: AppAssets.svgFat,
                          ),
                        ],
                      ),
                      10.verticalSpace,
                      TextButton(
                        onPressed: onNutritionSummary,
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
                      ElevatedButton(
                        onPressed: onAddMealType,
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(1.sw, 48.h),
                        ),
                        child: Text(
                          loc.addFood,
                          style: theme.primaryTextTheme.headlineSmall,
                        ),
                      ),
                      15.verticalSpace,
                      onStateView(
                        mealListData,
                        child: (data) {
                          final selectedMealType =
                              ref.watch(selectedMealTypeProvider);
                          final mealList = data.whereOrEmpty(
                            (element) =>
                                element.mealType?.toLowerCase() ==
                                selectedMealType.toLowerCase(),
                          );
                          return selectedMealType == loc.hydration
                              ? const HydrationWidget()
                              : mealList?.isNotEmpty == true
                                  ? DiaryWidget(
                                      mealList: mealList,
                                      onAddMeal: () =>
                                          onAddMeal(selectedMealType),
                                    )
                                  : Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(50),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            30.verticalSpace,
                                            Text(
                                              'Empty Data',
                                              textAlign: TextAlign.center,
                                              style:
                                                  theme.textTheme.displaySmall,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                        },
                      ),
                      100.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
