import 'package:hive_flutter/hive_flutter.dart';
import 'package:nutrogen/data/model/user_model.dart';
import 'package:nutrogen/res/app_constants.dart';

class DbService {
  final Box box;
  const DbService({required this.box});

  static Future init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    await Hive.openBox(AppConstants.appName);
  }

  Iterable<dynamic> values({Box? box}) => (box ?? this.box).values;

  Iterable<dynamic> valuesBetween({
    required dynamic startKey,
    required dynamic endKey,
    Box? box,
  }) =>
      (box ?? this.box).valuesBetween(startKey: startKey, endKey: endKey);

  Future<void> put<T>({
    required dynamic key,
    required T value,
    Box? box,
  }) async =>
      await (box ?? this.box).put(key, value);

  Future<void> putAt<T>({
    required int index,
    required T value,
    Box? box,
  }) async =>
      await (box ?? this.box).putAt(index, value);

  Future<void> putAll<T>({required Map<dynamic, T> value, Box? box}) async =>
      await (box ?? this.box).putAll(value);

  Future<void> delete({required dynamic key, Box? box}) async =>
      await (box ?? this.box).delete(key);

  Future<void> deleteAt({required int index, Box? box}) async =>
      await (box ?? this.box).deleteAt(index);

  Future<void> deleteAll({required Iterable<dynamic> keys, Box? box}) async =>
      await (box ?? this.box).deleteAll(keys);

  Future<void> deleteFromDisk({Box? box}) async =>
      await (box ?? this.box).deleteFromDisk();

  T? get<T>({required dynamic key, Box? box, dynamic defaultValue}) =>
      (box ?? this.box).get(key, defaultValue: defaultValue);

  Future<T?> getAt<T>({required int key, Box? box}) async =>
      await (box ?? this.box).getAt(key);

  Map getAll({Box? box}) => (box ?? this.box).toMap();

  Stream<BoxEvent> watch({required dynamic key, Box? box}) =>
      (box ?? this.box).watch(key: key);

  Future<int> add({required dynamic value, Box? box}) async =>
      await (box ?? this.box).add(value);

  Future<Iterable<int>> addAll({
    required Iterable<dynamic> value,
    Box? box,
  }) async =>
      await (box ?? this.box).addAll(value);

  bool containsKey({required int key, Box? box}) =>
      (box ?? this.box).containsKey(key);

  Future<void> flush({Box? box}) async => await (box ?? this.box).flush();

  Future<void> close({Box? box}) async => await (box ?? this.box).close();

  Future<void> clear({Box? box}) async => await (box ?? this.box).clear();
}
