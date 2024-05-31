import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/ui/module/genratedAiPlan/widget/selecte_item.dart';
import 'package:nutrogen/utils/helper.dart';

class AddRecipeSix extends HookConsumerWidget {
  const AddRecipeSix({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> planList = [
      'High-Fiber',
      'Low-Fiber',
      'Low-Sodium',
      'Low-Magnesium',
      'Low-Potassium',
      'Low-Iron',
    ];

    List<String> planList2 = [
      '15 min',
      '30 min',
      '40 min',
      '50 min',
      '1hr+',
    ];

    final selectedFoodType = useState<List<String>>([]);

    void onFoodType(String text) {
      if (selectedFoodType.value.contains(text)) {
        final list = selectedFoodType.value;
        list.remove(text);

        selectedFoodType.value = [...list];
        return;
      }

      selectedFoodType.value = [...selectedFoodType.value, text];
    }

    final selectedMealType = useState<List<String>>([]);

    void onMealType(String text) {
      if (selectedMealType.value.contains(text)) {
        final list = selectedMealType.value;
        list.remove(text);

        selectedMealType.value = [...list];
        return;
      }

      selectedMealType.value = [...selectedMealType.value, text];
    }

    final selectedCookingMethod = useState<List<String>>([]);

    void onCookingMethod(String text) {
      if (selectedCookingMethod.value.contains(text)) {
        final list = selectedCookingMethod.value;
        list.remove(text);

        selectedCookingMethod.value = [...list];
        return;
      }

      selectedCookingMethod.value = [...selectedCookingMethod.value, text];
    }

    final selectedIngredients = useState<List<String>>([]);

    void onIngredients(String text) {
      if (selectedIngredients.value.contains(text)) {
        final list = selectedIngredients.value;
        list.remove(text);

        selectedIngredients.value = [...list];
        return;
      }

      selectedIngredients.value = [...selectedIngredients.value, text];
    }

    final selectedCookingTime = useState<List<String>>([]);

    void onCookingTime(String text) {
      if (selectedCookingTime.value.contains(text)) {
        final list = selectedCookingTime.value;
        list.remove(text);

        selectedCookingTime.value = [...list];
        return;
      }

      selectedCookingTime.value = [...selectedCookingTime.value, text];
    }

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  loc.otherinfo,
                  style: theme.textTheme.displaySmall,
                ),
              ],
            ),
            20.verticalSpace,
            Text(
              loc.foodType,
              style: theme.textTheme.headlineSmall,
            ),
            15.verticalSpace,
            SelectedItem(
              planList: planList,
              selectedList: selectedFoodType.value,
              onSelect: onFoodType,
            ),
            20.verticalSpace,
            Text(
              loc.mealType,
              style: theme.textTheme.headlineSmall,
            ),
            15.verticalSpace,
            SelectedItem(
              planList: planList,
              selectedList: selectedMealType.value,
              onSelect: onMealType,
            ),
            20.verticalSpace,
            Text(
              loc.cookingMethod,
              style: theme.textTheme.headlineSmall,
            ),
            15.verticalSpace,
            SelectedItem(
              planList: planList,
              selectedList: selectedCookingMethod.value,
              onSelect: onCookingMethod,
            ),
            20.verticalSpace,
            Text(
              loc.ingredients,
              style: theme.textTheme.headlineSmall,
            ),
            15.verticalSpace,
            SelectedItem(
              planList: planList,
              selectedList: selectedIngredients.value,
              onSelect: onIngredients,
            ),
            20.verticalSpace,
            Text(
              loc.cookingTime,
              style: theme.textTheme.headlineSmall,
            ),
            15.verticalSpace,
            SelectedItem(
              planList: planList2,
              selectedList: selectedCookingTime.value,
              onSelect: onCookingTime,
            ),
          ],
        ),
      ),
    );
  }
}
