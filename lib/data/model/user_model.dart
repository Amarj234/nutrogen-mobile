import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@HiveType(typeId: 0)
@freezed
class UserModel with _$UserModel {
  factory UserModel({
    @HiveField(0) @JsonKey(name: '_id') String? id,
    @HiveField(1) @JsonKey(name: 'clientAdminID') String? clientAdminId,
    @HiveField(2) @JsonKey(name: 'branchID') String? branchId,
    @HiveField(3) String? firstName,
    @HiveField(4) String? lastName,
    @HiveField(5) String? profilePicture,
    @HiveField(6) String? dob,
    @HiveField(7) String? gender,
    @HiveField(8) int? age,
    @HiveField(9) String? email,
    @HiveField(10) String? phone,
    @HiveField(11) String? phoneNoCountryCode,
    @HiveField(12) String? password,
    @HiveField(13) String? unitMeasurements,
    @HiveField(14) int? weight,
    @HiveField(15) int? height,
    @HiveField(16) String? achievement,
    @HiveField(17) String? howActiveYourAre,
    @HiveField(18) int? mealPerDay,
    @HiveField(29) String? mealPlanPreference,
    @HiveField(20) String? dateOfJoined,
    @HiveField(21) String? createdAt,
    @HiveField(22) String? updatedAt,
    @HiveField(23) @JsonKey(name: '__v') int? v,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
