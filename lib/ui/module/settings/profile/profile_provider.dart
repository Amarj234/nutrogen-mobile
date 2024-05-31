import 'package:nutrogen/data/model/login_model.dart';
import 'package:nutrogen/data/model/request/update_profile_request.dart';
import 'package:nutrogen/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_provider.g.dart';

@riverpod
FutureOr<LoginModel?> userProfileCall(UserProfileCallRef ref) {
  return ref.watch(userRepositoryProvider).userProfile();
}

@riverpod
class UserUpdate extends _$UserUpdate {
  @override
  FutureOr<LoginModel?> build() {
    return null;
  }

  Future<void> userUpdateCall({required ProfileUpdateRequest request}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.watch(userRepositoryProvider).updateProfile(request: request),
    );
  }
}
