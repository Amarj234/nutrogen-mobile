import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/utils/app_log.dart';

class StateObserver extends ProviderObserver {
  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    AppLog.i(
      'ADD: ${provider.name ?? provider.runtimeType} -> $value',
      name: 'Riverpod',
    );
  }

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    AppLog.i(
      'UPDATE: ${provider.name ?? provider.runtimeType} -> $newValue',
      name: 'Riverpod',
    );
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    AppLog.i(
      'DISPOSE: ${provider.name ?? provider.runtimeType}',
      name: 'Riverpod',
    );
  }

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    AppLog.e(
      'ERROR: ${provider.name ?? provider.runtimeType} -> $error',
      name: 'Riverpod',
    );
  }
}
