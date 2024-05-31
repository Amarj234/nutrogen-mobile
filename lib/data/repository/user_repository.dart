import 'package:nutrogen/data/model/base_model.dart';
import 'package:nutrogen/data/model/branch_list_model.dart';
import 'package:nutrogen/data/model/login_model.dart';
import 'package:nutrogen/data/model/package_list_model.dart';
import 'package:nutrogen/data/model/registration_props_model.dart';
import 'package:nutrogen/data/model/request/register_request.dart';
import 'package:nutrogen/data/model/request/update_profile_request.dart';
import 'package:nutrogen/data/service/api_service.dart';
import 'package:nutrogen/data/service/db_service.dart';

class UserRepository {
  final ApiService apiService;
  final DbService dbService;
  const UserRepository({required this.apiService, required this.dbService});

  Future<LoginModel?> login({
    required String email,
    required String password,
  }) async =>
      apiService.call(
        endPoint: 'public/login',
        fromJson: LoginModel.fromJson,
        data: {'email': email, 'password': password},
      );

  Future<BaseModel?> register({required RegisterRequest request}) async {
    return apiService.call(
      endPoint: 'public/register-user',
      fromJson: BaseModel.fromJson,
      data: request.toJson(),
    );
  }

  Future<RegistrationPropsModel?> registrationProps({
    required String type,
  }) async =>
      apiService.call(
        endPoint: 'public/props-list-by-type',
        method: 'get',
        fromJson: RegistrationPropsModel.fromJson,
        query: {'type': type},
      );

  Future<LoginModel?> userProfile() async => apiService.call(
        endPoint: 'eub/me',
        method: 'get',
        fromJson: LoginModel.fromJson,
      );

  Future<BranchListModel?> branchList() async => apiService.call(
        endPoint: 'public/branch-list',
        method: 'get',
        fromJson: BranchListModel.fromJson,
      );

  Future<LoginModel?> updateProfile({
    required ProfileUpdateRequest request,
  }) async =>
      apiService.call(
        endPoint: 'eub/me-update',
        fromJson: LoginModel.fromJson,
        data: request.toJson(),
      );

  Future<PackageListModel?> packageList({required String branchId}) async =>
      apiService.call(
        endPoint: 'public/enduser-package-list',
        method: 'get',
        fromJson: PackageListModel.fromJson,
        query: {'branchID': branchId},
      );
}
