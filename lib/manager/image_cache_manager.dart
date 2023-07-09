import 'package:flutter_cache_manager/flutter_cache_manager.dart';

const _kImageCache = 'PCImageCache';

final imageCacheManager = CacheManager(
  Config(
    _kImageCache,
    stalePeriod: const Duration(days: 7),
    maxNrOfCacheObjects: 500,
  ),
);