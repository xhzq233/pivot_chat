import 'package:framework/logger.dart';

import 'base_box_manager.dart';

final spManager = PCSPManager._();

// shared preferences manager
class PCSPManager extends PCBaseBoxManager<String, String> {
  PCSPManager._();

  Future<void> setVal<T>(String key, T? value) {
    return update(key, value?.toString());
  }

  T? getVal<T>(String key) {
    final String? val = get(key);
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
        logger.w('SP', 'Unsupported type: $T');
        return null;
      }
    }
  }
}
