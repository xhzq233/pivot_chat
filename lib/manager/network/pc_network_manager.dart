import 'dart:async';
import 'package:pivot_chat/manager/account_manager.dart';
import 'package:pivot_chat/manager/network/http_method_type.dart';
import 'package:pivot_chat/manager/network/pc_base_network_manager.dart';
import 'package:pivot_chat/manager/network/token_getter.dart';
import 'package:utils/logger.dart';
import '../../model/example_model.dart';

final netWorkManager = PCNetworkManager._()..tokenGetter = accountManager;

class PCNetworkManager extends PCBaseNetworkManager {
  PCNetworkManager._() {
    logger.i('NetworkManager init');
  }

  /// example
  Future<PCExampleModel?> getExample() =>
      sendRequest(HttpMethodType.get, '/example', PCExampleModel.fromJson);

  Future<Map<String, Object>?> setExample(PCExampleModel model) => sendRequest(
        HttpMethodType.post,
        '/set_example',
        (data) => data,
        cmd: model.toJson(),
      );

  @override
  late final TokenGetter tokenGetter;
}
