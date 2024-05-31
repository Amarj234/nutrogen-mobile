import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_profile_request.freezed.dart';
part 'update_profile_request.g.dart';

@freezed
class ProfileUpdateRequest with _$ProfileUpdateRequest {
  factory ProfileUpdateRequest({
    String? firstName,
    String? lastName,
    String? email,
    String? gender,
    String? age,
    String? unitMeasurements,
    String? weight,
    String? height,
    String? achievement,
    String? howActiveYourAre,
    String? branchID,
    String? clientAdminID,
    String? dateOfJoined,
    String? dob,
    @JsonKey(name: 'fcm_token') String? fcmToken,
    String? mealPerDay,
    String? mealPlanPreference,
    String? phone,
    String? phoneNoCountryCode,
    String? profilePicture,
  }) = _ProfileUpdateRequest;

  factory ProfileUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$ProfileUpdateRequestFromJson(json);
}
