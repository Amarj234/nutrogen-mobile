import 'package:freezed_annotation/freezed_annotation.dart';

part 'registration_props_model.freezed.dart';
part 'registration_props_model.g.dart';

@freezed
class RegistrationPropsModel with _$RegistrationPropsModel {
  factory RegistrationPropsModel({
    bool? status,
    List<RegistrationPropsData>? r,
    String? message,
  }) = _RegistrationPropsModel;

  factory RegistrationPropsModel.fromJson(Map<String, dynamic> json) =>
      _$RegistrationPropsModelFromJson(json);
}

@freezed
class RegistrationPropsData with _$RegistrationPropsData {
  factory RegistrationPropsData({
    @JsonKey(name: '_id') String? id,
    String? propName,
    String? propAlternativeName,
    int? propsType,
    DateTime? createdAt,
    DateTime? updatedAt,
    @JsonKey(name: '__v') int? v,
  }) = _RegistrationPropsData;

  factory RegistrationPropsData.fromJson(Map<String, dynamic> json) =>
      _$RegistrationPropsDataFromJson(json);
}
