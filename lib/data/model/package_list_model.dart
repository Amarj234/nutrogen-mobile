import 'package:freezed_annotation/freezed_annotation.dart';

part 'package_list_model.freezed.dart';
part 'package_list_model.g.dart';

@freezed
class PackageListModel with _$PackageListModel {
  factory PackageListModel({
    bool? status,
    List<PackageR>? r,
    String? message,
    int? count,
  }) = _PackageListModel;

  factory PackageListModel.fromJson(Map<String, dynamic> json) =>
      _$PackageListModelFromJson(json);
}

@freezed
class PackageR with _$PackageR {
  factory PackageR({
    @JsonKey(name: '_id') String? id,
    String? code,
    @JsonKey(name: 'clientAdminID') ClientAdminId? clientAdminId,
    @JsonKey(name: 'branchID') BranchId? branchId,
    String? name,
    int? price,
    @JsonKey(name: 'price_type') String? priceType,
    @JsonKey(name: 'per_user_cost') int? perUserCost,
    @JsonKey(name: 'per_user_cost_type') String? perUserCostType,
    @JsonKey(name: 'trial_days') int? trialDays,
    List<PackageFeature>? packageFeature,
    DateTime? createdAt,
    DateTime? updatedAt,
    @JsonKey(name: '__v') int? v,
  }) = _PackageR;

  factory PackageR.fromJson(Map<String, dynamic> json) =>
      _$PackageRFromJson(json);
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

@freezed
class BranchId with _$BranchId {
  factory BranchId({
    String? code,
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'clientAdminID') String? clientAdminId,
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
  }) = _BranchId;

  factory BranchId.fromJson(Map<String, dynamic> json) =>
      _$BranchIdFromJson(json);
}

@freezed
class PackageFeature with _$PackageFeature {
  factory PackageFeature({
    @JsonKey(name: '_id') String? id,
    String? tierName,
    String? featureName,
    String? featureNameSlug,
    bool? permission,
    int? role,
    String? roleText,
    List<Module>? module,
    DateTime? createdAt,
    DateTime? updatedAt,
    @JsonKey(name: '__v') int? v,
    String? featureIcon,
  }) = _PackageFeature;

  factory PackageFeature.fromJson(Map<String, dynamic> json) =>
      _$PackageFeatureFromJson(json);
}

@freezed
class Module with _$Module {
  factory Module({
    String? moduleName,
    String? moduleSlugName,
    ModulePermisson? modulePermisson,
    List<dynamic>? module,
    @JsonKey(name: '_id') String? id,
  }) = _Module;

  factory Module.fromJson(Map<String, dynamic> json) => _$ModuleFromJson(json);
}

@freezed
class ModulePermisson with _$ModulePermisson {
  factory ModulePermisson({
    bool? create,
    bool? read,
    bool? update,
    bool? delete,
    @JsonKey(name: '_id') String? id,
  }) = _ModulePermisson;

  factory ModulePermisson.fromJson(Map<String, dynamic> json) =>
      _$ModulePermissonFromJson(json);
}
