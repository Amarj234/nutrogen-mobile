import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/data/model/meal_list_model.dart';
import 'package:nutrogen/providers.dart';
import 'package:nutrogen/utils/helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'log_food_provider.g.dart';

@riverpod
class MealList extends _$MealList {
  @override
  FutureOr<List<Meals>> build() {
    return mealListCall();
  }

  FutureOr<List<Meals>> mealListCall() async {
    final date = ref.watch(selectedDateProvider);
    final data = (await ref.watch(foodRepositoryProvider).listMeal())?.r ?? [];
    final selectedData = <Meals>[];

    for (MealData mealData in data) {
      final mealDate = DateTime.tryParse('${mealData.mealData}');

      if (mealDate?.day == date.day &&
          mealDate?.month == date.month &&
          mealDate?.year == date.year) {
        selectedData.addAll(mealData.meal ?? []);
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
