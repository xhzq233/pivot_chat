import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:pivot_chat/manager/image_cache_manager.dart';

class PCNetworkImage extends CachedNetworkImage {
  static Widget defaultErrorWidgetBuilder(
          BuildContext context, String url, dynamic error) =>
      const Placeholder();

  static Widget defaultPlaceHolderWidgetBuilder(
          BuildContext context, String url) =>
      const CupertinoActivityIndicator();

  PCNetworkImage({
    super.key,
    required super.imageUrl,
    super.width,
    super.height,
    super.fit,
    super.placeholder = defaultPlaceHolderWidgetBuilder,
    super.errorWidget = defaultErrorWidgetBuilder,
    super.fadeInDuration,
    super.fadeOutDuration,
    super.placeholderFadeInDuration,
    super.cacheKey,
    super.imageBuilder,
  }) : super(cacheManager: imageCacheManager);
}

class PCNetworkImageProvider extends CachedNetworkImageProvider {
  PCNetworkImageProvider(
    super.url, {
    super.maxWidth,
    super.maxHeight,
    super.cacheKey,
    super.errorListener,
  }) : super(cacheManager: imageCacheManager);
}
