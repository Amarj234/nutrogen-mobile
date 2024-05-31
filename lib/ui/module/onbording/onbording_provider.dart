import 'package:intl/intl.dart';
import 'package:nutrogen/data/model/base_model.dart';
import 'package:nutrogen/data/model/branch_list_model.dart';
import 'package:nutrogen/data/model/registration_props_model.dart';
import 'package:nutrogen/data/model/request/register_request.dart';
import 'package:nutrogen/providers.dart';
import 'package:nutrogen/utils/helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onbording_provider.g.dart';

@Riverpod(keepAlive: true)
class RegisterModel extends _$RegisterModel {
  @override
  RegisterRequest build() {
    return RegisterRequest(
      dob: DateFormat('yyyy-MM-dd')
          .format(DateTime.now().subtract(const Duration(days: 25 * 365))),
      clientAdminID: '65e5dc86748cb7c15592c058',
      dateOfJoined: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      profilePicture: 'n_a',
      phoneNoCountryCode: '+91',
      gender: loc.male,
      age: '25',
      unitMeasurements: loc.imperial,
      weight: '254',
      height: '254',
      fcmToken: 'FCM Token',
    );
  }

  void setFirstName(String value) {
    state = state.copyWith(firstName: value);
  }

  void setLastName(String value) {
    state = state.copyWith(lastName: value);
  }

  void setMobile(String value) {
    state = state.copyWith(phone: value);
  }

  void setEmail(String value) {
    state = state.copyWith(email: value);
  }

  void setPassword(String value) {
    state = state.copyWith(password: value);
  }

  void setBranchId(String value) {
    state = state.copyWith(branchID: value);
  }

  void setPackage(String value) {
    state = state.copyWith(package: value);
  }

  void setPackageType(String value) {
    state = state.copyWith(packageType: value);
  }

  void setPackagePrice(String value) {
    state = state.copyWith(packageTotalPrice: value);
  }

  void setGender(String value) {
    state = state.copyWith(gender: value);
  }

  void setAge(String value) {
    state = state.copyWith(age: value);
  }

  void setDob(String value) {
    state = state.copyWith(dob: value);
  }

  void setMeasurementUnit(String value) {
    state = state.copyWith(unitMeasurements: value);
  }

  void setWeight(String value) {
    state = state.copyWith(weight: value);
  }

  void setHeight(String value) {
    state = state.copyWith(height: value);
  }

  void setAchievement(String value) {
    state = state.copyWith(achievement: value);
  }

  void setActiveLevel(String value) {
    state = state.copyWith(howActiveYourAre: value);
  }

  void setMealPerDay(String value) {
    state = state.copyWith(mealPerDay: value);
  }

  void setMealPlanPreference(String value) {
    state = state.copyWith(mealPlanPreference: value);
  }
}

@riverpod
class Register extends _$Register {
  @override
  FutureOr<BaseModel?> build() {
    return null;
  }

  Future<void> registerCall({required RegisterRequest request}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.watch(userRepositoryProvider).register(request: request),
    );
  }
}

@riverpod
class RegisterProp extends _$RegisterProp {
  @override
  FutureOr<List<RegistrationPropsData>?> build({required String type}) {
    return _registerPropCall();
  }

  Future<List<RegistrationPropsData>?> _registerPropCall() async {
    return (await ref
            .watch(userRepositoryProvider)
            .registrationProps(type: type))
        ?.r;
  }
}

@riverpod
class Branches extends _$Branches {
  @override
  FutureOr<List<BranchR>?> build() {
    return _branchListCall();
  }

  Future<List<BranchR>?> _branchListCall() async {
    return (await ref.watch(userRepositoryProvider).branchList())?.r;
  }
}
