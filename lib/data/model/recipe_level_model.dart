import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_level_model.freezed.dart';
part 'recipe_level_model.g.dart';

@freezed
class RecipeLevelModel with _$RecipeLevelModel {
  factory RecipeLevelModel({
    bool? status,
    List<RecipeLevelData>? r,
    String? message,
    int? count,
  }) = _RecipeLevelModel;

  factory RecipeLevelModel.fromJson(Map<String, dynamic> json) =>
      _$RecipeLevelModelFromJson(json);
}

@freezed
class RecipeLevelData with _$RecipeLevelData {
  factory RecipeLevelData({
    @JsonKey(name: '_id') String? id,
    Pcid? pcid,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'category_description') String? categoryDescription,
    @JsonKey(name: 'category_picture') String? categoryPicture,
    @JsonKey(name: 'category_type') int? categoryType,
    @JsonKey(name: 'category_status') int? categoryStatus,
    String? createdAt,
    String? updatedAt,
    @JsonKey(name: '__v') int? v,
    String? code,
  }) = _RecipeLevelData;

  factory RecipeLevelData.fromJson(Map<String, dynamic> json) =>
      _$RecipeLevelDataFromJson(json);
}

@freezed
class Pcid with _$Pcid {
  factory Pcid({
    String? code,
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'category_description') String? categoryDescription,
    @JsonKey(name: 'category_picture') String? categoryPicture,
    @JsonKey(name: 'category_type') int? categoryType,
    @JsonKey(name: 'category_status') int? categoryStatus,
    String? createdAt,
    String? updatedAt,
    @JsonKey(name: '__v') int? v,
  }) = _Pcid;

  factory Pcid.fromJson(Map<String, dynamic> json) => _$PcidFromJson(json);
}
