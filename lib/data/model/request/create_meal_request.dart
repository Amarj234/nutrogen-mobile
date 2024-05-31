import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_meal_request.freezed.dart';
part 'create_meal_request.g.dart';

@freezed
class CreateMealRequest with _$CreateMealRequest {
  factory CreateMealRequest({
    String? mealData,
    List<Meal>? meal,
  }) = _CreateMealRequest;

  factory CreateMealRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateMealRequestFromJson(json);
}

@freezed
class Meal with _$Meal {
  factory Meal({
    String? mealType,
    String? recipes,
    String? food,
    int? mealUnitNumber,
    String? mealUnitType,
  }) = _Meal;

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);
}
