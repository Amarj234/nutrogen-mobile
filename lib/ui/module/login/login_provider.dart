import 'package:nutrogen/data/model/login_model.dart';
import 'package:nutrogen/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_provider.g.dart';

@riverpod
class Login extends _$Login {
  @override
  FutureOr<LoginModel?> build() {
    return null;
  }

  Future<void> loginCall({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .watch(userRepositoryProvider)
          .login(email: email, password: password),
    );
  }
}
