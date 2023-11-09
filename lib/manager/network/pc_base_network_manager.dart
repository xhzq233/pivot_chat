import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:pivot_chat/manager/network/http_method_type.dart';
import 'package:pivot_chat/manager/network/token_getter.dart';
import 'package:framework/logger.dart';

import 'http_model_decoder.dart';

part 'network_interceptor.dart';

const baseUrl = kReleaseMode ? 'http://xhzq233.tpddns.cn:10002' : 'http://xhzq233.tpddns.cn:10002';

const _tag = 'NETWORK';

abstract class PCBaseNetworkManager {
  PCBaseNetworkManager() {
    logger.i(_tag, 'init');
  }

  TokenGetter get tokenGetter;

  late final _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    responseType: ResponseType.json,
    contentType: 'application/json',
    receiveTimeout: const Duration(seconds: 5),
    connectTimeout: const Duration(seconds: 5),
    sendTimeout: const Duration(seconds: 5),
  ))
    ..interceptors.add(_CustomInterceptors(tokenGetter));

  Future<T?> sendRequest<T>(
    HttpMethodType methodType,
    String path,
    Decoder<T> decoder, {
    Map<String, Object?>? cmd,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    Map<String, dynamic>? queryParameters;
    Object? requestData;

    if (methodType == HttpMethodType.get) {
      queryParameters = cmd; // 只在get时把data放到url
    } else {
      requestData = jsonEncode(cmd);
    }

    Response<dynamic> res;
    T? responseData;
    try {
      final op = options?.copyWith(method: methodType.name) ?? Options(method: methodType.name);
      final requestOptions = op.compose(
        _dio.options,
        path,
        data: requestData,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
        cancelToken: cancelToken,
        sourceStackTrace: StackTrace.current,
      );

      res = await _dio.fetch(requestOptions);
      final responseDataJson = res.data;
      if (responseDataJson is! Map<String, dynamic>) {
        throw UnsupportedError('Response is not a JSON');
      }
      responseData = decoder.call(responseDataJson);
    } catch (e) {
      logger.e(_tag, 'request exception: REQ type: $T', e);
    }

    return responseData;
  }
}
