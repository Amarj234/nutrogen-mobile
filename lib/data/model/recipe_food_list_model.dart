import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nutrogen/data/model/meal_list_model.dart';

part 'recipe_food_list_model.freezed.dart';
part 'recipe_food_list_model.g.dart';

@freezed
class RecipeFoodListModel with _$RecipeFoodListModel {
  factory RecipeFoodListModel({
    bool? status,
    RecipeFoodList? r,
    String? message,
  }) = _RecipeFoodListModel;

  factory RecipeFoodListModel.fromJson(Map<String, dynamic> json) =>
      _$RecipeFoodListModelFromJson(json);
}

@freezed
class RecipeFoodList with _$RecipeFoodList {
  factory RecipeFoodList({
    List<Recipy>? recipies,
    int? recipiesCount,
    List<RecipiesByClientAdmin>? recipiesByClientAdmin,
    int? recipiesByClientAdminCount,
    List<Food>? food,
    int? foodcount,
  }) = _RecipeFoodList;

  factory RecipeFoodList.fromJson(Map<String, dynamic> json) =>
      _$RecipeFoodListFromJson(json);
}

@freezed
class RecipiesByClientAdmin with _$RecipiesByClientAdmin {
  factory RecipiesByClientAdmin({
    @JsonKey(name: '_id') String? id,
    String? code,
    Cid? cid,
    String? recipeName,
    String? recipeDescription,
    String? recipeImage,
    int? preperationMinutes,
    int? servingSize,
    List<String>? suitableFor,
    List<Ingredient>? ingredient,
    String? authorWebsite,
    String? authorName,
    List<String>? cookingSteps,
    String? tips,
    List<Label>? labels,
    String? createdAt,
    String? updatedAt,
    @JsonKey(name: '__v') int? v,
  }) = _RecipiesByClientAdmin;

  factory RecipiesByClientAdmin.fromJson(Map<String, dynamic> json) =>
      _$RecipiesByClientAdminFromJson(json);
}

@freezed
class Cid with _$Cid {
  factory Cid({
    @JsonKey(name: '_id') String? id,
    String? code,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'category_description') String? categoryDescription,
    @JsonKey(name: 'category_picture') String? categoryPicture,
    @JsonKey(name: 'category_type') int? categoryType,
    @JsonKey(name: 'category_status') int? categoryStatus,
    String? createdAt,
    String? updatedAt,
    @JsonKey(name: '__v') int? v,
  }) = _Cid;

  factory Cid.fromJson(Map<String, dynamic> json) => _$CidFromJson(json);
}