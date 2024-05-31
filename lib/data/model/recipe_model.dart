import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_model.freezed.dart';
part 'recipe_model.g.dart';

@freezed
class RecipeModel with _$RecipeModel {
  factory RecipeModel({
    bool? status,
    List<RecipeData>? r,
    String? message,
    int? count,
  }) = _RecipeModel;

  factory RecipeModel.fromJson(Map<String, dynamic> json) =>
      _$RecipeModelFromJson(json);
}

@freezed
class RecipeData with _$RecipeData {
  factory RecipeData({
    @JsonKey(name: '_id') String? id,
    String? code,
    Cid? cid,
    @JsonKey(name: 'clientAdminID') ClientAdminId? clientAdminId,
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
    DateTime? createdAt,
    DateTime? updatedAt,
    @JsonKey(name: '__v') int? v,
  }) = _RecipeData;

  factory RecipeData.fromJson(Map<String, dynamic> json) =>
      _$RecipeDataFromJson(json);
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
    DateTime? createdAt,
    DateTime? updatedAt,
    @JsonKey(name: '__v') int? v,
  }) = _Cid;

  factory Cid.fromJson(Map<String, dynamic> json) => _$CidFromJson(json);
}

@freezed
class ClientAdminId with _$ClientAdminId {
  factory ClientAdminId({
    @JsonKey(name: '_id') String? id,
    String? package,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? phoneNoCountryCode,
    String? businessName,
    String? legalName,
    String? businessAddress,
    String? country,
    String? city,
    String? state,
    String? timezone,
    String? website,
    String? logo,
    String? fabicon,
    String? whitelableDomain,
    String? apiDomain,
    int? role,
    @JsonKey(name: '__v') int? v,
    @JsonKey(name: 'step_five') int? stepFive,
    @JsonKey(name: 'step_four') int? stepFour,
    @JsonKey(name: 'step_one') int? stepOne,
    @JsonKey(name: 'step_three') int? stepThree,
    @JsonKey(name: 'step_two') int? stepTwo,
    String? primaryColour,
    String? secoundaryColour,
    @JsonKey(name: 'customCSS') String? customCss,
    String? customJavascript,
    @JsonKey(name: 'privacyURL') String? privacyUrl,
    @JsonKey(name: 'termsURL') String? termsUrl,
    String? code,
    String? tempPassword,
    int? tempPasswordStatus,
  }) = _ClientAdminId;

  factory ClientAdminId.fromJson(Map<String, dynamic> json) =>
      _$ClientAdminIdFromJson(json);
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
class Food with _$Food {
  factory Food({
    String? code,
    @JsonKey(name: '_id') String? id,
    String? foodName,
    @JsonKey(name: 'energy_kcal') int? energyKcal,
    @JsonKey(name: 'protein_g') double? proteinG,
    @JsonKey(name: 'carbohydrate_g') double? carbohydrateG,
    @JsonKey(name: 'fat_g') double? fatG,
    @JsonKey(name: 'starch_g') int? starchG,
    @JsonKey(name: 'sugar_g') double? sugarG,
    @JsonKey(name: 'added_sugar_g') int? addedSugarG,
    @JsonKey(name: 'saturated_fat_g') double? saturatedFatG,
    @JsonKey(name: 'polyunsatured_fat_g') int? polyunsaturedFatG,
    @JsonKey(name: 'cholesterol_mg') int? cholesterolMg,
    @JsonKey(name: 'trans_fat_mg') int? transFatMg,
    @JsonKey(name: 'sodium_mg') double? sodiumMg,
    @JsonKey(name: 'zinc_mg') int? zincMg,
    @JsonKey(name: 'calcium_mg') int? calciumMg,
    @JsonKey(name: 'potassium_mg') int? potassiumMg,
    @JsonKey(name: 'magnesium_mg') int? magnesiumMg,
    @JsonKey(name: 'iron_mg') int? ironMg,
    @JsonKey(name: 'phosphorus_mg') int? phosphorusMg,
    @JsonKey(name: 'iodine_ug') int? iodineUg,
    @JsonKey(name: 'selenium_ug') int? seleniumUg,
    @JsonKey(name: 'folate_ug') int? folateUg,
    @JsonKey(name: 'vitamin_a_ug') int? vitaminAUg,
    @JsonKey(name: 'vitamin_c_mg') int? vitaminCMg,
    @JsonKey(name: 'vitamin_e_mg') int? vitaminEMg,
    @JsonKey(name: 'thiamin_b1_mg') int? thiaminB1Mg,
    @JsonKey(name: 'riboflavin_b2_mg') int? riboflavinB2Mg,
    @JsonKey(name: 'niacin_b3_mg') int? niacinB3Mg,
    String? source,
  }) = _Food;

  factory Food.fromJson(Map<String, dynamic> json) => _$FoodFromJson(json);
}
