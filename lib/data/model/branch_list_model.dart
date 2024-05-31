import 'package:freezed_annotation/freezed_annotation.dart';

part 'branch_list_model.freezed.dart';
part 'branch_list_model.g.dart';

@freezed
class BranchListModel with _$BranchListModel {
  factory BranchListModel({
    bool? status,
    List<BranchR>? r,
    String? message,
    int? count,
  }) = _BranchListModel;

  factory BranchListModel.fromJson(Map<String, dynamic> json) =>
      _$BranchListModelFromJson(json);
}

@freezed
class BranchR with _$BranchR {
  factory BranchR({
    String? code,
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'clientAdminID') ClientAdminId? clientAdminId,
    String? package,
    String? businessName,
    String? legalName,
    String? businessOwnerName,
    String? email,
    String? phone,
    String? phoneNoCountryCode,
    String? businessAddress,
    String? country,
    String? city,
    String? state,
    String? zipcode,
    String? timezone,
    String? website,
    String? logo,
    int? type,
    @JsonKey(name: '__v') int? v,
    List<dynamic>? permissionList,
  }) = _BranchR;

  factory BranchR.fromJson(Map<String, dynamic> json) =>
      _$BranchRFromJson(json);
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
    Branding? branding,
  }) = _ClientAdminId;

  factory ClientAdminId.fromJson(Map<String, dynamic> json) =>
      _$ClientAdminIdFromJson(json);
}

@freezed
class Branding with _$Branding {
  factory Branding({
    String? buttonColor,
    String? buttonTextColor,
    String? headerFontFamily,
    String? headerFontColor,
    String? headerHyperlinkColor,
    String? headerHyperlinkHoverColor,
    String? bodyFontFamily,
    String? bodyFontColor,
    String? bodyHyperlinkColor,
    String? bodyHyperlinkHoverColor,
  }) = _Branding;

  factory Branding.fromJson(Map<String, dynamic> json) =>
      _$BrandingFromJson(json);
}
