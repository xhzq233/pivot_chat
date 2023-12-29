import 'dart:async';
import 'package:dio/dio.dart';
import 'package:pivot_chat/manager/account_manager.dart';
import 'package:pivot_chat/manager/network/http_method_type.dart';
import 'package:pivot_chat/model/openim_spec_network.dart';
import 'package:pivot_chat/manager/network/pc_base_network_manager.dart';
import 'package:pivot_chat/manager/network/token_getter.dart';
import '../../model/example_model.dart';
import 'http_model_decoder.dart';

final netWorkManager = PCNetworkManager._()..tokenGetter = accountManager;

class PCNetworkManager extends PCBaseNetworkManager {
  PCNetworkManager._();

  Future<OpenIMBaseResp<T>?> sendOpenImRequest<T>(
    HttpMethodType methodType,
    String path,
    Decoder<T> decoder, {
    Map<String, Object?>? cmd,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final headers = options?.headers ?? {};
    headers['operationID'] = DateTime.now().millisecondsSinceEpoch.toString();
    final options_ = options?.copyWith(headers: headers) ?? Options(headers: headers);

    final OpenIMBaseResp<T>? resp = await sendRequest(
      methodType,
      path,
      (data) => OpenIMBaseResp.fromJson(data, (Object? obj) {
        if (obj is Map<String, dynamic>) {
          return decoder(obj);
        }
        throw Exception('decoder error');
      }),
      cmd: cmd,
      cancelToken: cancelToken,
      options: options_,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    return resp;
  }

  /// example
  Future<PCExampleModel?> getExample() => sendRequest(HttpMethodType.get, '/example', PCExampleModel.fromJson);

  Future<Object?> setExample(PCExampleModel model) => sendRequest(
        HttpMethodType.post,
        '/set_example',
        (data) => data,
        cmd: model.toJson(),
      );

  Future<OpenIMBaseResp<OpenIMTokenResp>?> getToken(String uid) => sendOpenImRequest(
        HttpMethodType.post,
        '/auth/user_token',
        OpenIMTokenResp.fromJson,
        cmd: {"secret": "openIM123", "platformID": 1, "userID": uid},
      );

  Future<OpenIMBaseResp<dynamic>?> register({required String uid,String nickname = 'unknown',
      String faceUrl = "https://blog.xhzq.xyz/images/avatar.jpeg"}) =>
      sendOpenImRequest(
        HttpMethodType.post,
        '/user/user_register',
        OpenIMTokenResp.fromJson,
        cmd: {
          "secret": "openIM123",
          "users": [
            {"userID": uid, "nickname": nickname, "faceURL": faceUrl}
          ],
        },
      );

  @override
  late final TokenGetter tokenGetter;
}
