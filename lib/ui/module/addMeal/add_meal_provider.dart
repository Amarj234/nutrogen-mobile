import 'package:nutrogen/data/model/create_meal_model.dart';
import 'package:nutrogen/data/model/recipe_food_list_model.dart';
import 'package:nutrogen/data/model/recipe_level_model.dart';
import 'package:nutrogen/data/model/request/create_meal_request.dart';
import 'package:nutrogen/data/model/unit_list_model.dart';
import 'package:nutrogen/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_meal_provider.g.dart';

@riverpod
class RecipeList extends _$RecipeList {
  @override
  FutureOr<RecipeFoodList?> build() {
    return null;
  }

  Future<void> recipeListCall({
    required String pageSize,
    required String pageNumber,
  }) async {
    final datas = await AsyncValue.guard(
      () => ref
          .watch(foodRepositoryProvider)
          .recipeFoodList(pageNumber: pageNumber, pageSize: pageSize),
    );

    datas.whenOrNull(
      data: (data) async {
        if (pageNumber == '1') {
          state = await AsyncValue.guard(
            () async => data?.r,
          );
        } else {
          if (data?.status == true) {
            final RecipeFoodList? listFood = data?.r?.copyWith(
              food: [...?state.value?.food, ...?data.r?.food],
              recipies: [...?state.value?.recipies, ...?data.r?.recipies],
            );
            state = AsyncData(listFood);
          }
        }
      },
      error: (error, stackTrace) {
        if (pageNumber == '1') {
          state = AsyncError(error, stackTrace);
        }
      },
    );
  }
}

@riverpod
class CreateMeal extends _$CreateMeal {
  @override
  FutureOr<CreateMealModel?> build() {
    return null;
  }

  Future<void> createMealCall({required CreateMealRequest request}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.watch(foodRepositoryProvider).createMeal(request: request),
    );
  }
}

@riverpod
FutureOr<List<UnitListData>> unitListCall(UnitListCallRef ref) async {
  return (await ref.watch(foodRepositoryProvider).unitList())?.r ?? [];
}

@riverpod
FutureOr<List<RecipeLevelData>> recipeLevelCall(RecipeLevelCallRef ref) async {
  return (await ref.watch(foodRepositoryProvider).recipeLevel())?.r ?? [];
}
