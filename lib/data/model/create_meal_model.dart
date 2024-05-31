import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_meal_model.freezed.dart';
part 'create_meal_model.g.dart';

@freezed
class CreateMealModel with _$CreateMealModel {
  factory CreateMealModel({
    bool? status,
    R? r,
    String? message,
  }) = _CreateMealModel;

  factory CreateMealModel.fromJson(Map<String, dynamic> json) =>
      _$CreateMealModelFromJson(json);
}

@freezed
class R with _$R {
  factory R({
    @JsonKey(name: 'userID') String? userId,
    String? mealData,
    List<Meal>? meal,
    @JsonKey(name: '_id') String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    @JsonKey(name: '__v') int? v,
  }) = _R;

  factory R.fromJson(Map<String, dynamic> json) => _$RFromJson(json);
}

@freezed
class Meal with _$Meal {
  factory Meal({
    String? mealType,
    String? recipes,
    int? mealUnitNumber,
    String? mealUnitType,
    @JsonKey(name: '_id') String? id,
  }) = _Meal;

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);
}
