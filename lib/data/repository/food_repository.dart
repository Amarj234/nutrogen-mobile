import 'package:nutrogen/data/model/meal_plan_model.dart';
import 'package:nutrogen/data/model/create_meal_model.dart';
import 'package:nutrogen/data/model/meal_list_model.dart';
import 'package:nutrogen/data/model/recipe_food_list_model.dart';
import 'package:nutrogen/data/model/recipe_level_model.dart';
import 'package:nutrogen/data/model/recipe_model.dart';
import 'package:nutrogen/data/model/request/create_meal_request.dart';
import 'package:nutrogen/data/model/unit_list_model.dart';
import 'package:nutrogen/data/service/api_service.dart';
import 'package:nutrogen/data/service/db_service.dart';

class FoodRepository {
  final ApiService apiService;
  final DbService dbService;
  const FoodRepository({required this.apiService, required this.dbService});

  Future<RecipeModel?> recipeList() async => apiService.call(
        endPoint: 'public/recipe-filter',
        method: 'get',
        fromJson: RecipeModel.fromJson,
      );

  Future<CreateMealModel?> createMeal({
    required CreateMealRequest request,
  }) async =>
      apiService.call(
        endPoint: 'eub/create-meal',
        fromJson: CreateMealModel.fromJson,
        data: request.toJson(),
      );

  Future<UnitListModel?> unitList() async => apiService.call(
        endPoint: 'public/unit-list-p',
        method: 'get',
        fromJson: UnitListModel.fromJson,
      );

  Future<RecipeLevelModel?> recipeLevel() async => apiService.call(
        endPoint: 'eub/recipe-levels',
        method: 'get',
        fromJson: RecipeLevelModel.fromJson,
      );

  Future<RecipeFoodListModel?> recipeFoodList({
    required String pageSize,
    required String pageNumber,
  }) async =>
      apiService.call(
        endPoint: 'eub/recipe-food-list',
        method: 'get',
        fromJson: RecipeFoodListModel.fromJson,
        query: {'pageSize': pageSize, 'pageNumber': pageNumber},
      );

  Future<MealListModel?> listMeal() async => apiService.call(
        endPoint: 'eub/list-meal',
        method: 'get',
        fromJson: MealListModel.fromJson,
      );

  Future<MealPlanModel?> approveListMeal() async => apiService.call(
        endPoint: 'eub/get-all-mealplan',
        method: 'get',
        fromJson: MealPlanModel.fromJson,
      );
}
