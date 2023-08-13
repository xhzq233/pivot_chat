import 'package:hive/hive.dart';
import 'package:pivot_chat/model/identifable.dart';
import 'package:utils/logger.dart';

mixin PCBaseBoxManager<Key, T> {
  late final Box<T> _box;

  final String kBoxName = T.toString();

  bool opened = false;

  Future<void> init() async {
    logger.i('Init $T');
    if (opened) {
      return;
    }
    _box = await Hive.openBox<T>(kBoxName);
    opened = true;
  }

  void remove([Key? key]) {
    if (key == null) {
      logger.d('RemoveAll $T');
      _box.clear();
    } else {
      logger.d('Remove $T by key: $key');
      _box.delete(key);
    }
  }

  T? get(Key? key) {
    if (key == null) {
      logger.w('Try to get null $T');
      return null;
    }
    final res = _box.get(key);
    logger.d('Get $T: $res by key: $key');
    return res;
  }

  Iterable<T> getAll() {
    final values = _box.values;
    logger.d('GetAll $T, values: $values');
    return values;
  }

  Stream<BoxEvent> watch({Key? key}) => _box.watch(key: key);

  bool get isEmpty => _box.isEmpty;
}

extension PCBaseBoxManagerExt<T extends Identifable<Key>, Key>
    on PCBaseBoxManager<Key, T> {
  void put(T? val) {
    if (val == null) {
      logger.w('Try to put null $T');
      return;
    }
    logger.d('Put $T: $val');
    _box.put(val.id, val);
  }

  void putAll(Iterable<T> list) {
    logger.d('PutAll $T: $list');
    for (var value in list) {
      _box.put(value.id, value);
    }
  }
}
