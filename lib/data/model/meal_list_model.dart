import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nutrogen/data/model/recipe_food_list_model.dart';

part 'meal_list_model.freezed.dart';
part 'meal_list_model.g.dart';

@freezed
class MealListModel with _$MealListModel {
  factory MealListModel({
    bool? status,
    List<MealData>? r,
    String? message,
  }) = _MealListModel;

  factory MealListModel.fromJson(Map<String, dynamic> json) =>
      _$MealListModelFromJson(json);
}

@freezed
class MealData with _$MealData {
  factory MealData({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'userID') String? userId,
    String? mealData,
    List<Meals>? meal,
    String? createdAt,
    String? updatedAt,
    @JsonKey(name: '__v') int? v,
  }) = _MealData;

  factory MealData.fromJson(Map<String, dynamic> json) =>
      _$MealDataFromJson(json);
}

@freezed
class Meals with _$Meals {
  factory Meals({
    String? mealType,
    Recipy? recipes,
    Food? food,
    int? mealUnitNumber,
    String? mealUnitType,
    @JsonKey(name: '_id') String? id,
  }) = _Meals;

  factory Meals.fromJson(Map<String, dynamic> json) => _$MealsFromJson(json);
}

@freezed
class Recipy with _$Recipy {
  factory Recipy({
    @JsonKey(name: '_id') String? id,
    String? code,
    dynamic? cid,
    @JsonKey(name: 'clientAdminID') String? clientAdminId,
    String? recipeName,
    String? recipeDescription,
    String? recipeImage,
    int? preperationMinutes,
    int? servingSize,
    List<String?>? suitableFor,
    List<Ingredient>? ingredient,
    String? authorWebsite,
    String? authorName,
    List<String>? cookingSteps,
    String? tips,
    List<Label>? labels,
    String? createdAt,
    String? updatedAt,
    @JsonKey(name: '__v') int? v,
  }) = _Recipy;

  factory Recipy.fromJson(Map<String, dynamic> json) => _$RecipyFromJson(json);
}

@freezed
class Ingredient with _$Ingredient {
  factory Ingredient({
    Food? food,
    int? quantity,
    String? unit,
    @JsonKey(name: '_id') String? id,
  }) = _Ingredient;

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);
}

@freezed
class Food with _$Food {
  factory Food({
    String? code,
    @JsonKey(name: '_id') String? id,
    String? foodName,
    @JsonKey(name: 'energy_kcal') double? energyKcal,
    @JsonKey(name: 'protein_g') double? proteinG,
    @JsonKey(name: 'carbohydrate_g') double? carbohydrateG,
    @JsonKey(name: 'fat_g') double? fatG,
    @JsonKey(name: 'starch_g') double? starchG,
    @JsonKey(name: 'sugar_g') double? sugarG,
    @JsonKey(name: 'added_sugar_g') double? addedSugarG,
    @JsonKey(name: 'saturated_fat_g') double? saturatedFatG,
    @JsonKey(name: 'polyunsatured_fat_g') double? polyunsaturedFatG,
    @JsonKey(name: 'cholesterol_mg') double? cholesterolMg,
    @JsonKey(name: 'trans_fat_mg') double? transFatMg,
    @JsonKey(name: 'sodium_mg') double? sodiumMg,
    @JsonKey(name: 'zinc_mg') double? zincMg,
    @JsonKey(name: 'calcium_mg') double? calciumMg,
    @JsonKey(name: 'potassium_mg') double? potassiumMg,
    @JsonKey(name: 'magnesium_mg') double? magnesiumMg,
    @JsonKey(name: 'iron_mg') double? ironMg,
    @JsonKey(name: 'phosphorus_mg') double? phosphorusMg,
    @JsonKey(name: 'iodine_ug') double? iodineUg,
    @JsonKey(name: 'selenium_ug') double? seleniumUg,
    @JsonKey(name: 'folate_ug') double? folateUg,
    @JsonKey(name: 'vitamin_a_ug') double? vitaminAUg,
    @JsonKey(name: 'vitamin_c_mg') double? vitaminCMg,
    @JsonKey(name: 'vitamin_e_mg') double? vitaminEMg,
    @JsonKey(name: 'thiamin_b1_mg') double? thiaminB1Mg,
    @JsonKey(name: 'riboflavin_b2_mg') double? riboflavinB2Mg,
    @JsonKey(name: 'niacin_b3_mg') double? niacinB3Mg,
    String? source,
  }) = _Food;

  factory Food.fromJson(Map<String, dynamic> json) => _$FoodFromJson(json);
}

@freezed
class Label with _$Label {
  factory Label({
    int? index,
    String? labelName,
    String? labelCategory,
    List<String>? labelValue,
    @JsonKey(name: '_id') String? id,
  }) = _Label;

  factory Label.fromJson(Map<String, dynamic> json) => _$LabelFromJson(json);
}
