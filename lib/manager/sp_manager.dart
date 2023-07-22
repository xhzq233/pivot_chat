import 'package:hive_flutter/hive_flutter.dart';

final spManager = PCSPManager._();

// shared preferences manager
class PCSPManager {
  PCSPManager._();

  static const _kBoxName = 'pc_sp';
  late final Box<String> _box;

  Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(_kBoxName);
  }

  Future<void> clear() async {
    await _box.clear();
  }

  Future<void> remove(String key) async {
    await _box.delete(key);
  }

  Future<void> setVal<T>(String key, T? value) async {
    if (null == value) {
      await _box.delete(key);
    } else {
      await _box.put(key, value.toString());
    }
  }

  T? getVal<T>(String key) {
    final val = _box.get(key);
    if (null == val) {
      return null;
    } else {
      return val as T;
    }
  }

  Stream<BoxEvent> watch(String? key) => _box.watch(key: key);
}
