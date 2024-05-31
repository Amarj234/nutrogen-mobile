import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutrogen/data/repository/food_repository.dart';
import 'package:nutrogen/data/repository/user_repository.dart';
import 'package:nutrogen/data/service/api_service.dart';
import 'package:nutrogen/data/service/db_service.dart';
import 'package:nutrogen/res/app_constants.dart';
import 'package:nutrogen/res/app_routers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

/* -------------------------------------------------------------------------- */
/*                                    CORE                                    */
/* -------------------------------------------------------------------------- */

@Riverpod(keepAlive: true)
Dio dio(DioRef ref) {
  final dio = Dio(baseOption);
  dio.interceptors.addAll([interceptor, retryInterceptor(dio)]);
  return dio;
}

@Riverpod(keepAlive: true)
Box box(BoxRef ref) => Hive.box(AppConstants.appName);

@Riverpod(keepAlive: true)
ApiService apiService(ApiServiceRef ref) =>
    ApiService(dio: ref.watch(dioProvider));

@Riverpod(keepAlive: true)
DbService dbService(DbServiceRef ref) => DbService(box: ref.watch(boxProvider));

@Riverpod(keepAlive: true)
AppRouters appRouters(AppRoutersRef ref) {
  return AppRouters();
}

@Riverpod(keepAlive: true)
ImagePicker imagePicker(ImagePickerRef ref) {
  return ImagePicker();
}

/* -------------------------------------------------------------------------- */
/*                                 REPOSITORY                                 */
/* -------------------------------------------------------------------------- */

@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) => UserRepository(
      apiService: ref.watch(apiServiceProvider),
      dbService: ref.watch(dbServiceProvider),
    );

@Riverpod(keepAlive: true)
FoodRepository foodRepository(FoodRepositoryRef ref) => FoodRepository(
      apiService: ref.watch(apiServiceProvider),
      dbService: ref.watch(dbServiceProvider),
    );

/* -------------------------------------------------------------------------- */
/*                                  PROVIDER                                  */
/* -------------------------------------------------------------------------- */
