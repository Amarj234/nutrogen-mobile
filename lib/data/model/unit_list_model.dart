import 'package:freezed_annotation/freezed_annotation.dart';

part 'unit_list_model.freezed.dart';
part 'unit_list_model.g.dart';

@freezed
class UnitListModel with _$UnitListModel {
  factory UnitListModel({
    bool? status,
    List<UnitListData>? r,
    String? message,
  }) = _UnitListModel;

  factory UnitListModel.fromJson(Map<String, dynamic> json) =>
      _$UnitListModelFromJson(json);
}

@freezed
class UnitListData with _$UnitListData {
  factory UnitListData({
    String? name,
    String? abbreviation,
  }) = _UnitListData;

  factory UnitListData.fromJson(Map<String, dynamic> json) =>
      _$UnitListDataFromJson(json);
}
