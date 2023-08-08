import 'package:hive_flutter/hive_flutter.dart';
import 'package:utils/logger.dart';

final spManager = PCSPManager._();

// shared preferences manager
class PCSPManager {
  PCSPManager._();

  static const _kBoxName = 'pc_sp';
  late final Box<String> _box;

  Future<void> init() async {
    _box = await Hive.openBox(_kBoxName);
    logger.d('Init PCSPManager, values: ${_box.values}');
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
      if (T == String) {
        return val as T;
      } else if (T == int) {
        return int.parse(val) as T;
      } else if (T == double) {
        return double.parse(val) as T;
      } else if (T == bool) {
        return (val == 'true') as T;
      } else if (T == List<String>) {
        return val.split(',') as T;
      } else {
        logger.w('Unsupported type: $T');
        return null;
      }
    }
  }

  Stream<BoxEvent> watch(String? key) => _box.watch(key: key);
}
