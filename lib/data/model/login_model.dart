import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nutrogen/data/model/user_model.dart';

part 'login_model.freezed.dart';
part 'login_model.g.dart';

@freezed
class LoginModel with _$LoginModel {
  factory LoginModel({
    bool? status,
    R? r,
    String? message,
  }) = _LoginModel;

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);
}

@freezed
class R with _$R {
  factory R({
    UserModel? user,
    String? token,
  }) = _R;

  factory R.fromJson(Map<String, dynamic> json) => _$RFromJson(json);
}
