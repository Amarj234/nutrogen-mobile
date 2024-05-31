import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_request.freezed.dart';
part 'register_request.g.dart';

@freezed
class RegisterRequest with _$RegisterRequest {
  factory RegisterRequest({
    @JsonKey(name: 'fcm_token') String? fcmToken,
    String? clientAdminID,
    String? package,
    String? packageType,
    String? packageTotalPrice,
    String? branchID,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? phone,
    String? phoneNoCountryCode,
    String? dob,
    String? gender,
    String? age,
    String? unitMeasurements,
    String? weight,
    String? height,
    String? achievement,
    String? howActiveYourAre,
    String? mealPerDay,
    String? mealPlanPreference,
    String? dateOfJoined,
    String? profilePicture,
  }) = _RegisterRequest;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);
}
