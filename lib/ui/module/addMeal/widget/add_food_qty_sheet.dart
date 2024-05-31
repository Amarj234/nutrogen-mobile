import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/data/model/meal_list_model.dart';
import 'package:nutrogen/data/model/request/create_meal_request.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/res/app_routers.dart';
import 'package:nutrogen/ui/common/dropdown_widget.dart';
import 'package:nutrogen/ui/common/image_widget.dart';
import 'package:nutrogen/ui/common/state_popup.dart';
import 'package:nutrogen/ui/common/state_view.dart';
import 'package:nutrogen/ui/module/addMeal/add_meal_provider.dart';
import 'package:nutrogen/ui/module/logFood/log_food_provider.dart';
import 'package:nutrogen/utils/helper.dart';

class AddFoodQtySheet extends HookConsumerWidget {
  const AddFoodQtySheet({
    required this.mealType,
    required this.mealDate,
    required this.recipies,
    required this.food,
    super.key,
  });

  final List<Recipy> recipies;
  final List<Food> food;
  final String? mealType;
  final String? mealDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedMeal = useRef(CreateMealRequest(mealData: mealDate));

    useEffect(
      () {
        selectedMeal.value = selectedMeal.value.copyWith(
          meal: [
            ...recipies.map(
              (e) => Meal(
                mealType: mealType,
                recipes: e.id,
                mealUnitNumber: 1,
              ),
            ),
            ...food.map(
              (e) => Meal(
                mealType: mealType,
                food: e.id,
                mealUnitNumber: 1,
              ),
            ),
          ],
        );
        return null;
      },
      [],
    );

    void onAddTo() {
      if (selectedMeal.value.meal
              ?.any((element) => element.mealUnitType == null) ==
          true) {
        showCommonDialog(loc.pleaseSelectUnitType);
        return;
      }
      ref
          .read(createMealProvider.notifier)
          .createMealCall(request: selectedMeal.value);
    }

    ref.listen(
      createMealProvider,
      (previous, next) => onStatePopup(
        next,
        onSuccess: (data) {
          ref.invalidate(mealListProvider);
          context.goNamed(AppRouters.logFood);
        },
      ),
    );

    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
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
          Text(
            loc.addquantitytothefoods,
            style: theme.textTheme.displaySmall,
          ),
          25.verticalSpace,
          ListView.separated(
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              double carbs = 0;
              double fat = 0;
              double protein = 0;

              recipies[index].ingredient?.forEach((element) {
                carbs = carbs + (element.food?.carbohydrateG ?? 0);
                fat = fat + (element.food?.fatG ?? 0);
                protein = protein + (element.food?.proteinG ?? 0);
              });

              final contains =
                  'Carbs ${carbs.round()}g, Fat ${fat.round()}g, Protein ${protein.round()}g';

              return AddQuantityWidget(
                recipeId: '${recipies[index].id}',
                recipeImage: '${recipies[index].recipeImage}',
                recipeName: '${recipies[index].recipeName}',
                continents: contains,
                selectedMeal: selectedMeal,
              );
            },
            separatorBuilder: (context, index) => Divider(
              color: AppColors.platinum,
              height: 30.h,
              thickness: 1.h,
            ),
            itemCount: recipies.length,
          ),
          Divider(
            color: AppColors.platinum,
            height: 30.h,
            thickness: 1.h,
          ),
          ListView.separated(
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              double carbs = 0;
              double fat = 0;
              double protein = 0;

              carbs = food[index].carbohydrateG ?? 0;
              fat = food[index].fatG ?? 0;
              protein = food[index].proteinG ?? 0;

              final contains =
                  'Carbs ${carbs.round()}g, Fat ${fat.round()}g, Protein ${protein.round()}g';

              return AddQuantityWidget(
                recipeId: '${food[index].id}',
                recipeImage: '${food[index].foodName}',
                recipeName: '${food[index].foodName}',
                continents: contains,
                selectedMeal: selectedMeal,
              );
            },
            separatorBuilder: (context, index) => Divider(
              color: AppColors.platinum,
              height: 30.h,
              thickness: 1.h,
            ),
            itemCount: food.length,
          ),
          30.verticalSpace,
          ElevatedButton(
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
                    '${selectedMeal.value.meal?.length}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontFamily: AppAssets.fontPlusJakartaSans,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AddQuantityWidget extends HookConsumerWidget {
  const AddQuantityWidget({
    required this.recipeId,
    required this.recipeImage,
    required this.recipeName,
    required this.continents,
    required this.selectedMeal,
    super.key,
  });

  final String recipeId;
  final String recipeImage;
  final String recipeName;
  final String continents;
  final ObjectRef<CreateMealRequest> selectedMeal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = useState(1);
    final timer = useRef<Timer?>(null);

    void onCountMinus({bool isTouch = false}) {
      if (isTouch) {
        timer.value ??= Timer.periodic(
          const Duration(milliseconds: 50),
          (timer) {
            if (count.value > 1) {
              count.value--;
            }
          },
        );
      } else {
        if (count.value > 1) {
          count.value--;
        }
      }
      final meal = selectedMeal.value.meal
          ?.map(
            (e) => e.recipes == recipeId || e.food == recipeId
                ? e.copyWith(mealUnitNumber: count.value)
                : e,
          )
          .toList();

      selectedMeal.value = selectedMeal.value.copyWith(meal: meal);
    }

    void onCountPlus({bool isTouch = false}) {
      if (isTouch) {
        timer.value ??= Timer.periodic(
          const Duration(milliseconds: 50),
          (timer) {
            count.value++;
          },
        );
      } else {
        count.value++;
      }
      final meal = selectedMeal.value.meal
          ?.map(
            (e) => e.recipes == recipeId || e.food == recipeId
                ? e.copyWith(mealUnitNumber: count.value)
                : e,
          )
          .toList();

      selectedMeal.value = selectedMeal.value.copyWith(meal: meal);
    }

    void onTapUp() {
      timer.value?.cancel();
      timer.value = null;
    }

    void onUnitType(String? text) {
      final meal = selectedMeal.value.meal
          ?.map(
            (e) => e.recipes == recipeId || e.food == recipeId
                ? e.copyWith(mealUnitType: text)
                : e,
          )
          .toList();

      selectedMeal.value = selectedMeal.value.copyWith(meal: meal);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: ImageWidget(
            recipeImage,
            width: 54.w,
            height: 54.w,
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
                continents,
                style: theme.textTheme.titleSmall
                    ?.copyWith(color: AppColors.darkSilver),
              ),
              10.verticalSpace,
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 18.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.platinum),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: onCountMinus,
                          onLongPressStart: (_) => onCountMinus(isTouch: true),
                          onLongPressEnd: (_) => onTapUp(),
                          child: Text('-', style: theme.textTheme.titleLarge),
                        ),
                        25.horizontalSpace,
                        Text(
                          '${count.value}',
                          style: theme.textTheme.bodyMedium,
                        ),
                        25.horizontalSpace,
                        GestureDetector(
                          child: Text('+', style: theme.textTheme.titleLarge),
                          onTap: () => onCountPlus(),
                          onLongPressStart: (_) => onCountPlus(isTouch: true),
                          onLongPressEnd: (_) => onTapUp(),
                        ),
                      ],
                    ),
                  ),
                  5.horizontalSpace,
                  Consumer(
                    builder: (context, ref, child) {
                      final unitTypeData = ref.watch(unitListCallProvider);
                      return onStateView(
                        unitTypeData,
                        child: (data) => SizedBox(
                          height: 40.h,
                          width: 120.w,
                          child: DropDownWidget(
                            textcolor: AppColors.eerieBlack,
                            bordercolor: AppColors.platinum,
                            onTap: onUnitType,
                            list: data.map((e) => '${e.abbreviation}').toList(),
                            hint: loc.type,
                          ),
                        ),
                      );
                    },
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
