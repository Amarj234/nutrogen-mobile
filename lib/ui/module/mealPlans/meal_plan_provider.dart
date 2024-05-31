import 'package:nutrogen/data/model/meal_plan_model.dart';
import 'package:nutrogen/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'meal_plan_provider.g.dart';

@riverpod
FutureOr<List<MealPlanR?>> mealListCall(MealListCallRef ref) async {
  return (await ref.watch(foodRepositoryProvider).approveListMeal())?.r ?? [];
}
