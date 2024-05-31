import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/data/model/meal_plan_model.dart';
import 'package:nutrogen/data/model/recipe_level_model.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/res/app_constants.dart';
import 'package:nutrogen/res/app_routers.dart';
import 'package:nutrogen/ui/common/state_view.dart';
import 'package:nutrogen/ui/module/addMeal/add_meal_provider.dart';
import 'package:nutrogen/ui/module/logFood/log_food_page.dart';
import 'package:nutrogen/ui/module/mealPlans/meal_plan_provider.dart';
import 'package:nutrogen/ui/module/mealPlans/widget/allergy_filters_page.dart';
import 'package:nutrogen/ui/module/mealPlans/widget/mean_plan_widget.dart';
import 'package:nutrogen/utils/helper.dart';

class DieticianApproveMealPlan extends HookConsumerWidget {
  const DieticianApproveMealPlan({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    void onAddMealType(MealPlanR? data) async {
      context.pushNamed(AppRouters.mealPlanDetails, extra: data);
    }

    final mealData = useState<List<MealPlanR?>>([]);
    final fillterdata = useState<List<MealPlanR?>>([]);

    final isfilter = useState(true);
    final selectedFilterPreference =
        useState<Map<Pcid?, List<RecipeLevelData>?>?>(null);

    void onFilter(
      MapEntry<Pcid?, List<RecipeLevelData>?> recipeLevelData,
    ) async {
      await showModalBottomSheet(
        context: context,
        backgroundColor: AppColors.white,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        ),
        builder: (context) => AllergyFilters(
          recipeLevelData: recipeLevelData,
          selectedRecipeLevel:
              selectedFilterPreference.value?[recipeLevelData.key],
          onApply: (levelData) {
            Map<Pcid?, List<RecipeLevelData>?> data = {};
            data.addAll(selectedFilterPreference.value ?? {});
            fillterdata.value.clear();
            data.addEntries({levelData.key: levelData.value}.entries);
            selectedFilterPreference.value = data;
            selectedFilterPreference.value?.entries.forEach((elementa) {
              for (var element in mealData.value) {
                element?.tags?.forEach((elements) {
                  elementa.value?.forEach((elementf) {
                    if (elements.labelValue!.contains(elementf.categoryName)) {
                      if (fillterdata.value.isEmpty) {
                        fillterdata.value.add(element);
                      } else {
                        for (var elementAs in fillterdata.value) {
                          if (elementAs?.id != element.id) {
                            fillterdata.value.add(element);
                          }
                        }
                      }
                    }
                  });
                });
              }

              // fillterdata.value.add(element.categoryName);
            });
            if (selectedFilterPreference.value![recipeLevelData.key]!.isEmpty) {
              isfilter.value = true;
            } else {
              isfilter.value = false;
            }
//
//             selectedFilterPreference.value?.entries.forEach((elementd) {
//               print(elementd.value);
//             });
          },
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: ScreenUtil().statusBarHeight,
            color: AppColors.white,
          ),
          Expanded(
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  floating: false,
                  pinned: false,
                  automaticallyImplyLeading: false,
                  toolbarHeight: 38.h,
                  backgroundColor: AppColors.white,
                  flexibleSpace: Column(
                    children: [
                      10.verticalSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: 38.w,
                                height: 38.w,
                                padding: EdgeInsets.all(4.w),
                                decoration: const BoxDecoration(
                                  color: AppColors.cultured,
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(AppAssets.svgBackArrow),
                              ),
                            ),
                            10.horizontalSpace,
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 42.h,
                                decoration: BoxDecoration(
                                  color: AppColors.antiFlashWhite,
                                  borderRadius: BorderRadius.circular(35.r),
                                ),
                                child: Row(
                                  children: [
                                    20.horizontalSpace,
                                    SvgPicture.asset(
                                      AppAssets.svgSearchYellow,
                                      colorFilter: const ColorFilter.mode(
                                        AppColors.quickSilver,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    6.horizontalSpace,
                                    Expanded(
                                      child: TextField(
                                        controller: searchController,
                                        style: theme.textTheme.titleSmall
                                            ?.copyWith(
                                          color: AppColors.smokyBlack,
                                        ),
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.only(
                                            top: 0,
                                            bottom: 10,
                                          ),
                                          hintText: loc.search,
                                          hintStyle: theme.textTheme.titleSmall
                                              ?.copyWith(
                                            color: AppColors.darkSilver,
                                          ),
                                          border: InputBorder.none,
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
                    ],
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  floating: false,
                  delegate: SliverAppBarDelegate(
                    minHeight: 58.h,
                    maxHeight: 58.h,
                    child: Stack(
                      children: [
                        Container(
                          height: 58.h,
                          color: AppColors.white,
                        ),
                        Consumer(
                          builder: (context, ref, child) {
                            final recipeLevelData =
                                ref.watch(recipeLevelCallProvider);

                            return onStateView(
                              recipeLevelData,
                              child: (data) {
                                final Map<Pcid?, List<RecipeLevelData>?>
                                    levelMap = {};

                                for (RecipeLevelData level in data) {
                                  levelMap.addEntries(
                                    {
                                      level.pcid: [
                                        ...?levelMap[level.pcid],
                                        level,
                                      ],
                                    }.entries,
                                  );
                                }

                                return ListView.separated(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20.w,
                                    vertical: 8.h,
                                  ),
                                  scrollDirection: Axis.horizontal,
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: levelMap.length,
                                  separatorBuilder: (context, index) =>
                                      10.horizontalSpace,
                                  itemBuilder: (context, index) =>
                                      ElevatedButton(
                                    onPressed: () => onFilter(
                                      levelMap.entries.toList()[index],
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20.w,
                                      ),
                                      elevation: 0,
                                      backgroundColor: AppColors.cultured,
                                      fixedSize: Size.fromHeight(
                                        38.h,
                                      ),
                                    ),
                                    child: Text(
                                      '${levelMap.keys.toList()[index]?.categoryName}: ${selectedFilterPreference.value?[levelMap.keys.toList()[index]]?.isNotEmpty == true ? selectedFilterPreference.value![levelMap.keys.toList()[index]]?.map((e) => '${e.categoryName}').join(', ') : 'All'}',
                                      style: theme.textTheme.titleSmall,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              body: Consumer(
                builder: (context, ref, child) {
                  final approveMealData = ref.watch(mealListCallProvider);

                  return onStateView(
                    approveMealData,
                    child: (data) {
                      mealData.value.addAll(data);
                      return isfilter.value
                          ? ListView.separated(
                              padding: EdgeInsets.all(20.h),
                              itemBuilder: (context, index) => MeanPlanWidget(
                                onTap: () {
                                  onAddMealType(data[index]);
                                },
                                rating:
                                    data[index]?.mealPerDay.toString() ?? '',
                                kcal: data[index]!
                                    .excludeIngredients![0]
                                    .energyKcal
                                    .toString(),
                                alligned: data[index]!.limitProtein.toString(),
                                title: data[index]?.mealPlanName ?? '',
                                image:
                                    '${AppConstants.baseImageUrl}${data[index]?.mealPlanImage}',
                                cholesterol: data[index]!
                                    .excludeIngredients![0]
                                    .cholesterolMg
                                    .toString(),
                                protein: data[index]!
                                    .excludeIngredients![0]
                                    .proteinG
                                    .toString(),
                                fat: data[index]!
                                    .excludeIngredients![0]
                                    .fatG
                                    .toString(),
                              ),
                              separatorBuilder: (context, index) =>
                                  15.verticalSpace,
                              itemCount: data.length,
                            )
                          : fillterdata.value.isEmpty
                              ? const Center(
                                  child: Text('Data not Found'),
                                )
                              : ListView.separated(
                                  padding: EdgeInsets.all(20.h),
                                  itemBuilder: (context, index) =>
                                      MeanPlanWidget(
                                    onTap: () {
                                      onAddMealType(fillterdata.value[index]);
                                    },
                                    rating: fillterdata.value[index]?.mealPerDay
                                            .toString() ??
                                        '',
                                    kcal: fillterdata.value[index]!
                                        .excludeIngredients![0].energyKcal
                                        .toString(),
                                    alligned: fillterdata
                                        .value[index]!.limitProtein
                                        .toString(),
                                    title: fillterdata
                                            .value[index]?.mealPlanName ??
                                        '',
                                    image:
                                        '${AppConstants.baseImageUrl}${fillterdata.value[index]?.mealPlanImage}',
                                    cholesterol: fillterdata.value[index]!
                                        .excludeIngredients![0].cholesterolMg
                                        .toString(),
                                    protein: fillterdata.value[index]!
                                        .excludeIngredients![0].proteinG
                                        .toString(),
                                    fat: fillterdata.value[index]!
                                        .excludeIngredients![0].fatG
                                        .toString(),
                                  ),
                                  separatorBuilder: (context, index) =>
                                      15.verticalSpace,
                                  itemCount: fillterdata.value.length,
                                );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
