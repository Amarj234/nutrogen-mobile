import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nutrogen/data/model/meal_list_model.dart';

part 'meal_plan_model.freezed.dart';
part 'meal_plan_model.g.dart';

@freezed
class MealPlanModel with _$MealPlanModel {
  factory MealPlanModel({
    bool? status,
    List<MealPlanR>? r,
    String? message,
    int? count,
  }) = _MealPlanModel;

  factory MealPlanModel.fromJson(Map<String, dynamic> json) =>
      _$MealPlanModelFromJson(json);
}

@freezed
class MealPlanR with _$MealPlanR {
  factory MealPlanR({
    @JsonKey(name: '_id') String? id,
    String? code,
    @JsonKey(name: 'clientAdminID') ClientAdminId? clientAdminId,
    String? mealPlanName,
    String? mealPlanNameDescription,
    String? mealPlanImage,
    int? howLongNumber,
    String? howLongType,
    int? mealPerDay,
    String? goal,
    List<dynamic>? healthAllergies,
    String? caloriesType,
    int? caloriesPerDay,
    int? limitProtein,
    int? limitCarbohydrates,
    int? limitFat,
    List<Tag>? tags,
    List<Food>? excludeIngredients,
    List<MealPlanMeta>? mealPlanMeta,
    int? mealPlanType,
    String? createdAt,
    String? updatedAt,
    @JsonKey(name: '__v') int? v,
  }) = _MealPlanR;

  factory MealPlanR.fromJson(Map<String, dynamic> json) =>
      _$MealPlanRFromJson(json);
}

@freezed
class ClientAdminId with _$ClientAdminId {
  factory ClientAdminId({
    @JsonKey(name: '_id') String? id,
    String? code,
    String? package,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? phoneNoCountryCode,
    @JsonKey(name: 'step_one') int? stepOne,
    @JsonKey(name: 'step_two') int? stepTwo,
    @JsonKey(name: 'step_three') int? stepThree,
    @JsonKey(name: 'step_four') int? stepFour,
    @JsonKey(name: 'step_five') int? stepFive,
    int? role,
    @JsonKey(name: '__v') int? v,
    int? tempPasswordStatus,
  }) = _ClientAdminId;

  factory ClientAdminId.fromJson(Map<String, dynamic> json) =>
      _$ClientAdminIdFromJson(json);
}

@freezed
class Ingredient with _$Ingredient {
  factory Ingredient({
    int? quantity,
    String? unit,
    @JsonKey(name: '_id') String? id,
    Food? food,
  }) = _Ingredient;

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);
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

@freezed
class MealPlanMeta with _$MealPlanMeta {
  factory MealPlanMeta({
    String? day,
    String? mealName,
    List<Food>? food,
    List<Recipy>? recipe,
    @JsonKey(name: '_id') String? id,
  }) = _MealPlanMeta;

  factory MealPlanMeta.fromJson(Map<String, dynamic> json) =>
      _$MealPlanMetaFromJson(json);
}

@freezed
class Tag with _$Tag {
  factory Tag({
    int? index,
    String? labelName,
    String? labelCategory,
    List<String>? labelValue,
    @JsonKey(name: '_id') String? id,
  }) = _Tag;

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
}
