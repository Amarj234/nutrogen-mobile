import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/data/model/meal_list_model.dart';
import 'package:nutrogen/data/model/meal_plan_model.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/ui/common/state_view.dart';
import 'package:nutrogen/ui/module/logFood/log_food_page.dart';
import 'package:nutrogen/ui/module/logFood/widget/hydration_widget.dart';
import 'package:nutrogen/ui/module/mealPlans/meal_list_provider.dart';
import 'package:nutrogen/ui/module/mealPlans/widget/day_consumption.dart';
import 'package:nutrogen/ui/module/mealPlans/widget/plan_widget.dart';
import 'package:nutrogen/utils/helper.dart';
import 'package:nutrogen/utils/helper_extension.dart';
import 'package:nutrogen/utils/horizontal_date_picker.dart';

class MealPlanLog extends HookConsumerWidget {
  const MealPlanLog({super.key});

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

    void onDateSelect(DateTime date) {
      ref.read(selectedDateProvider.notifier).state = date;
    }

    final mealListData = ref.watch(selectMealListProvider);

    final foodContinent = useState(Food());

    mealListData.whenData((value) {
      foodContinent.value = Food();
      for (var meal in value) {
        meal.recipe?.forEach((element) {
          element.ingredient?.forEach((element) {
            foodContinent.value =
                collectFood(foodContinent.value, element.food!);
          });
        });
        meal.food?.forEach((element) {
          foodContinent.value = collectFood(foodContinent.value, element);
        });
      }
    });

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            height: ScreenUtil().statusBarHeight,
          ),
          Expanded(
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  floating: false,
                  pinned: false,
                  collapsedHeight: 115.h,
                  expandedHeight: 115.h,
                  backgroundColor: Colors.white,
                  flexibleSpace: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 20.w),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                //  padding: EdgeInsets.zero,
                                child: SvgPicture.asset(
                                  AppAssets.svgCloseGray,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              loc.myMealPlan,
                              style: theme.textTheme.bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.cultured,
                              ),
                              margin: EdgeInsets.only(right: 10.w),
                              padding: EdgeInsets.all(13.w),
                              child: PopupMenuButton<int>(
                                color: AppColors.white,
                                surfaceTintColor: AppColors.white,
                                elevation: 20,
                                splashRadius: 10.r,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                shadowColor: AppColors.black.withOpacity(0.5),
                                child: SvgPicture.asset(AppAssets.svgThreeDots),
                                itemBuilder: (context) => [
                                  PopupMenuItem<int>(
                                    value: 0,
                                    height: 34.h,
                                    padding: EdgeInsets.zero,
                                    child: Row(
                                      children: [
                                        20.horizontalSpace,
                                        SvgPicture.asset(AppAssets.svgStar),
                                        6.horizontalSpace,
                                        Text(
                                          'Save',
                                          style: theme.textTheme.bodyMedium,
                                        ),
                                        40.horizontalSpace,
                                      ],
                                    ),
                                    onTap: () {},
                                  ),
                                ],
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
              body: Column(
                children: [
                  Consumer(
                    builder: (context, ref, child) => onStateView(
                      mealListData,
                      child: (data) {
                        final selectedMealType =
                            ref.watch(selectedMealTypeProvider);

                        final mealList = data.whereOrEmpty(
                          (element) => selectedMealType == loc.lunch
                              ? element.mealName?.toLowerCase() == '2' ||
                                  element.mealName?.toLowerCase() ==
                                      loc.lunch.toLowerCase()
                              : selectedMealType == loc.snacks
                                  ? element.mealName?.toLowerCase() == '3' ||
                                      element.mealName?.toLowerCase() ==
                                          loc.snacks.toLowerCase()
                                  : selectedMealType == loc.dinner
                                      ? element.mealName?.toLowerCase() ==
                                              '4' ||
                                          element.mealName?.toLowerCase() ==
                                              loc.dinner.toLowerCase()
                                      : selectedMealType == loc.breakfast
                                          ? element.mealName?.toLowerCase() ==
                                                  '1' ||
                                              element.mealName?.toLowerCase() ==
                                                  loc.breakfast
                                          : false,
                        );

                        final List<Recipy> recipies = [];

                        final List<Food> foods = [];

                        for (var element in mealList ?? <MealPlanMeta>[]) {
                          recipies.addAll(element.recipe?.toList() ?? []);
                          foods.addAll(element.food?.toList() ?? []);
                        }

                        return selectedMealType == loc.hydration
                            ? const HydrationWidget()
                            : recipies.isNotEmpty == true ||
                                    foods.isNotEmpty == true
                                ? PlanWidget(
                                    onAddMeal: () {},
                                    recipies: recipies,
                                    foods: foods,
                                    title: mealList?[0]
                                                    .mealName
                                                    ?.toLowerCase() ==
                                                loc.lunch.toLowerCase() ||
                                            mealList?[0].mealName == '2'
                                        ? loc.lunch
                                        : mealList?[0]
                                                        .mealName
                                                        ?.toLowerCase() ==
                                                    loc.snacks.toLowerCase() ||
                                                mealList?[0].mealName == '3'
                                            ? loc.snacks
                                            : mealList?[0]
                                                            .mealName
                                                            ?.toLowerCase() ==
                                                        loc.dinner
                                                            .toLowerCase() ||
                                                    mealList?[0].mealName == '4'
                                                ? loc.dinner
                                                : loc.breakfast,
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
                                            style: theme.textTheme.displaySmall,
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
            ),
          ),
        ],
      ),
      bottomSheet: DraggableScrollableSheet(
        expand: false,
        shouldCloseOnMinExtent: false,
        snap: true,
        minChildSize: 0.12,
        initialChildSize: 0.12,
        maxChildSize: 0.46,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: DayConsumption(
            fat: '${(foodContinent.value.fatG ?? 0).round()}/70g',
            kcalRemaining:
                '${(1900 - (foodContinent.value.energyKcal ?? 0)).round() <= 0 ? 0 : (1900 - (foodContinent.value.energyKcal ?? 0)).round()}',
            protrin: '${(foodContinent.value.proteinG ?? 0).round()}/75g',
            carbohydrade:
                '${(foodContinent.value.carbohydrateG ?? 0).round()}/500g',
            item: (((foodContinent.value.energyKcal ?? 0) / 1900) * 100),
          ),
        ),
      ),
    );
  }
}
