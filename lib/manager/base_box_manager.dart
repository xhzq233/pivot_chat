import 'package:framework/list.dart';
import 'package:hive/hive.dart';
import 'package:framework/logger.dart';

abstract mixin class BaseCURD<Key, ItemType> {
  /// Provides all items.
  Iterable<ItemType> get values;

  /// Get [item] by [key].
  ItemType? get(Key key);

  /// Saves an [item] with auto increment key.
  ///
  /// If a [item] with the same key already exists, it will be replaced.
  Future<void> add(ItemType item);

  /// Update the [item] with the given [key].
  ///
  /// If [item] is null, the [item] with the given [key] is deleted.
  /// Throwing error when [key] not found.
  Future<void> update(Key key, ItemType? item);

  /// Deletes the `item` with the given id.
  ///
  /// If no `item` with the given id exists, a error is thrown.
  Future<void> delete({Key? key});
}

abstract mixin class PCBaseBoxManager<Key, ItemType> implements BaseCURD<Key, ItemType> {
  static const tag = 'BOX';

  late final Box<ItemType> _box;

  final String kBoxName = ItemType.toString();

  bool opened = false;

  Future<void> init() async {
    logger.d(tag, 'Init $runtimeType<$ItemType>');
    if (opened) {
      return;
    }
    _box = await Hive.openBox<ItemType>(kBoxName);
    opened = true;
  }

  @override
  Future<void> delete({Key? key}) async {
    if (key == null) {
      logger.d(tag, 'RemoveAll $ItemType');
      await _box.clear();
    } else {
      logger.d(tag, 'Remove $ItemType by key: $key');
      await _box.delete(key);
    }
  }

  @override
  Future<void> add(ItemType item) {
    logger.d(tag, 'Add $ItemType: $item');
    return _box.add(item);
  }

  @override
  ItemType? get(Key key) {
    final res = _box.get(key);
    logger.d(tag, 'Get $ItemType: $res by key: $key');
    return res;
  }

  @override
  Future<void> update(Key key, ItemType? item) {
    if (item != null) {
      logger.d(tag, 'Update/Add $ItemType: $item by key: $key');
      return _box.put(key, item);
    } else {
      logger.d(tag, 'Remove $ItemType by key: $key');
      return _box.delete(key);
    }
  }

  @override
  Iterable<ItemType> get values {
    final values = _box.values;
    logger.d(tag, 'GetAll $ItemType, values: $values');
    return values;
  }

  Stream<BoxEvent> watch({Key? key}) => _box.watch(key: key);

  bool get isEmpty => _box.isEmpty;
}

extension PCBaseBoxManagerExt<T extends BaseItemModel<Key>, Key> on PCBaseBoxManager<Key, T> {
  Future<void> put(T val) {
    logger.d(PCBaseBoxManager.tag, 'Put $T: $val');
    return _box.put(val.key, val);
  }

  Future<void> putAll(Iterable<T> list) {
    logger.d(PCBaseBoxManager.tag, 'PutAll $T: $list');
    return list.map((e) => _box.put(e.key, e)).wait;
  }
}
