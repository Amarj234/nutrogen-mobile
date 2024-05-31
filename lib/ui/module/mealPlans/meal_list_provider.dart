import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/data/model/meal_plan_model.dart';
import 'package:nutrogen/providers.dart';
import 'package:nutrogen/utils/helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'meal_list_provider.g.dart';

@riverpod
class SelectMealList extends _$SelectMealList {
  @override
  FutureOr<List<MealPlanMeta>> build() {
    return myMealPlan();
  }

  FutureOr<List<MealPlanMeta>> myMealPlan() async {
    final date = ref.watch(selectedDateProvider);
    final data =
        (await ref.watch(foodRepositoryProvider).approveListMeal())?.r ?? [];
    final selectedData = <MealPlanMeta>[];

    for (MealPlanR mealData in data) {
      final mealDate = DateTime.tryParse('${mealData.createdAt}');

      if (mealDate?.day == date.day &&
          mealDate?.month == date.month &&
          mealDate?.year == date.year) {
      selectedData.addAll(mealData.mealPlanMeta ?? []);
      }
    }

    return selectedData;
  }
}

final selectedMealTypeProvider = StateProvider<String>((ref) {
  return loc.breakfast;
});

final selectedDateProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});
