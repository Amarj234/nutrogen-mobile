import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/data/model/meal_list_model.dart';
import 'package:nutrogen/data/model/recipe_level_model.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/res/app_routers.dart';
import 'package:nutrogen/ui/common/image_widget.dart';
import 'package:nutrogen/ui/common/state_view.dart';
import 'package:nutrogen/ui/module/addMeal/add_meal_provider.dart';
import 'package:nutrogen/ui/module/addMeal/widget/add_food_qty_sheet.dart';
import 'package:nutrogen/ui/module/logFood/log_food_page.dart';
import 'package:nutrogen/ui/module/mealPlans/widget/allergy_filters_page.dart';
import 'package:nutrogen/utils/helper.dart';

class AddMealPage extends HookConsumerWidget {
  const AddMealPage({
    required this.mealType,
    required this.mealDate,
    super.key,
  });

  final String? mealType;
  final String? mealDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final pageNumber = useRef(0);
    final isLoading = useState(true);
    final selectedFilterPreference =
        useState<Map<Pcid?, List<RecipeLevelData>?>?>(null);
    final selectedFood = useState<List<Food>>([]);
    final selectedRecipe = useState<List<Recipy>>([]);
    final searchController = useTextEditingController();

    void onClose() {
      context.pop();
    }

    void onAdd() {}

    void onScan() {
      context.pushNamed(AppRouters.scanBarcode);
    }

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

            data.addEntries({levelData.key: levelData.value}.entries);
            selectedFilterPreference.value = data;
          },
        ),
      );
    }

    void onAddRecipe({Food? food, Recipy? recipy}) {
      if (food != null) {
        List<Food> foodList = [...selectedFood.value];
        if (foodList.any((element) => element.id == food.id)) {
          foodList.removeWhere(
            (element) => element.id == food.id,
          );
        } else {
          foodList.add(food);
        }
        selectedFood.value = foodList;
      } else if (recipy != null) {
        List<Recipy> recipeList = [...selectedRecipe.value];
        if (recipeList.any((element) => element.id == recipy.id)) {
          recipeList.removeWhere(
            (element) => element.id == recipy.id,
          );
        } else {
          recipeList.add(recipy);
        }
        selectedRecipe.value = recipeList;
      }
    }

    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          scrollController.addListener(() async {
            if (scrollController.position.pixels >=
                scrollController.position.maxScrollExtent) {
              isLoading.value = true;
              await ref.read(recipeListProvider.notifier).recipeListCall(
                    pageNumber: '${pageNumber.value + 1}',
                    pageSize: '30',
                  );
              isLoading.value = false;
            }
          });
          isLoading.value = true;
          await ref.read(recipeListProvider.notifier).recipeListCall(
                pageNumber: '${pageNumber.value}',
                pageSize: '30',
              );
          isLoading.value = false;
        });
        return null;
      },
      [],
    );

    void onAddTo() async {
      await showModalBottomSheet(
        backgroundColor: AppColors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.4,
          maxChildSize: 0.9,
          builder: (context, scrollController) => Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                SingleChildScrollView(
                  controller: scrollController,
                  child: AddFoodQtySheet(
                    mealDate: mealDate,
                    mealType: mealType,
                    food: selectedFood.value,
                    recipies: selectedRecipe.value,
                  ),
                ),
              ],
            ),
          ),
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
                  toolbarHeight: 110.h,
                  backgroundColor: AppColors.white,
                  flexibleSpace: Column(
                    children: [
                      10.verticalSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: onClose,
                              padding: EdgeInsets.zero,
                              icon: SvgPicture.asset(AppAssets.svgCloseGray),
                            ),
                            Text(
                              '${loc.add} $mealType',
                              style: theme.textTheme.bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            IconButton(
                              onPressed: onAdd,
                              padding: EdgeInsets.zero,
                              icon: SvgPicture.asset(AppAssets.svgPlusBg),
                            ),
                          ],
                        ),
                      ),
                      8.verticalSpace,
                      Row(
                        children: [
                          20.horizontalSpace,
                          Expanded(
                            flex: 3,
                            child: Container(
                              height: 60.h,
                              decoration: BoxDecoration(
                                color: AppColors.antiFlashWhite,
                                borderRadius: BorderRadius.circular(35.r),
                              ),
                              child: Row(
                                children: [
                                  20.horizontalSpace,
                                  SvgPicture.asset(AppAssets.svgSearchYellow),
                                  6.horizontalSpace,
                                  Expanded(
                                    child: TextField(
                                      controller: searchController,
                                      style:
                                          theme.textTheme.titleSmall?.copyWith(
                                        color: AppColors.smokyBlack,
                                      ),
                                      decoration: InputDecoration(
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
                          10.horizontalSpace,
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: onScan,
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                elevation: 0,
                                fixedSize: Size.fromHeight(60.h),
                                backgroundColor: AppColors.antiFlashWhite,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35.r),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(AppAssets.svgScan),
                                  4.horizontalSpace,
                                  Text(
                                    loc.scan,
                                    style: theme.primaryTextTheme.titleMedium
                                        ?.copyWith(
                                      color: AppColors.darkMidnightBlue,
                                      fontFamily: AppAssets.fontPlusJakartaSans,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          20.horizontalSpace,
                        ],
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
              body: Stack(
                children: [
                  Consumer(
                    builder: (context, ref, child) {
                      final recipeListData = ref.watch(recipeListProvider);

                      recipeListData.whenData((value) => pageNumber.value += 1);

                      final List<Recipy> recipies =
                          recipeListData.asData?.value?.recipies ?? [];
                      final List<Food> foods =
                          recipeListData.asData?.value?.food ?? [];

                      return SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          children: [
                            20.verticalSpace,
                            ListView.separated(
                              shrinkWrap: true,
                              primary: false,
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              itemBuilder: (context, index) {
                                const quantity = 1.0;
                                double energy = 0;

                                recipies[index].ingredient?.forEach((element) {
                                  energy =
                                      energy + (element.food?.energyKcal ?? 0);
                                });

                                return AddFoodWidget(
                                  recipeImage: '${recipies[index].recipeImage}',
                                  recipeName:
                                      '${quantity.round()} Cup, ${recipies[index].recipeName}',
                                  unitAndEnergy: '${energy.round()} Kcal',
                                  isSelected: selectedRecipe.value
                                      .contains(recipies[index]),
                                  onAddRecipe: () => onAddRecipe(
                                    recipy: recipies[index],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  10.verticalSpace,
                              itemCount: recipies.length,
                            ),
                            10.verticalSpace,
                            ListView.separated(
                              shrinkWrap: true,
                              primary: false,
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              itemBuilder: (context, index) {
                                const quantity = 1.0;
                                final energy =
                                    foods[index].energyKcal?.toDouble() ?? 0;
                                return AddFoodWidget(
                                  recipeImage: '${foods[index].foodName}',
                                  recipeName: '${foods[index].foodName}',
                                  unitAndEnergy:
                                      '${quantity.round()} Cup , ${energy.round()} Kcal',
                                  isSelected:
                                      selectedFood.value.contains(foods[index]),
                                  onAddRecipe: () =>
                                      onAddRecipe(food: foods[index]),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  10.verticalSpace,
                              itemCount: foods.length,
                            ),
                            10.verticalSpace,
                            Visibility(
                              visible: isLoading.value,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.darkMidnightBlue,
                                ),
                              ),
                            ),
                            Visibility(
                              visible: recipeListData.hasError &&
                                  !recipeListData.isLoading,
                              child: Padding(
                                padding: EdgeInsets.all(20.w),
                                child: Text(
                                  '${recipeListData.error}',
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.headlineSmall,
                                ),
                              ),
                            ),
                            120.verticalSpace,
                          ],
                        ),
                      );
                    },
                  ),
                  Visibility(
                    visible: selectedFood.value.isNotEmpty ||
                        selectedRecipe.value.isNotEmpty,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: 1.sw,
                            height: 140.h,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.cultured,
                                  AppColors.lightSilver.withOpacity(0),
                                ],
                                stops: const [0.0, 1.0],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 40.w,
                          right: 40.w,
                          bottom: 50.h,
                          child: ElevatedButton(
                            onPressed: onAddTo,
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.only(left: 26.w, right: 12.w),
                              backgroundColor: AppColors.darkMidnightBlue,
                              fixedSize: Size.fromHeight(52.h),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${loc.add} to $mealType - 234 kcal',
                                  style: theme.primaryTextTheme.headlineSmall,
                                ),
                                Container(
                                  height: 30.w,
                                  width: 30.w,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.goldenPoppy,
                                  ),
                                  child: Text(
                                    '${(selectedFood.value.length + selectedRecipe.value.length)}',
                                    style:
                                        theme.textTheme.titleMedium?.copyWith(
                                      fontFamily: AppAssets.fontPlusJakartaSans,
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
          ),
        ],
      ),
    );
  }
}

class AddFoodWidget extends StatelessWidget {
  const AddFoodWidget({
    required this.recipeImage,
    required this.recipeName,
    required this.unitAndEnergy,
    required this.onAddRecipe,
    required this.isSelected,
    super.key,
  });

  final String recipeImage;
  final String recipeName;
  final String unitAndEnergy;
  final bool isSelected;
  final VoidCallback onAddRecipe;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: ImageWidget(
            recipeImage,
            width: 70.w,
            height: 70.w,
            fit: BoxFit.cover,
          ),
        ),
        8.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                recipeName,
                style: theme.textTheme.titleMedium,
              ),
              1.verticalSpace,
              Text(
                unitAndEnergy,
                style: theme.textTheme.titleSmall
                    ?.copyWith(color: AppColors.darkSilver),
              ),
            ],
          ),
        ),
        6.horizontalSpace,
        IconButton(
          onPressed: onAddRecipe,
          style: IconButton.styleFrom(padding: EdgeInsets.all(3.w)),
          icon: SvgPicture.asset(
            isSelected ? AppAssets.svgTick : AppAssets.svgPlusWhite,
            height: 50.w,
            width: 50.w,
          ),
        ),
      ],
    );
  }
}
