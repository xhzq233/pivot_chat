import 'package:pivot_chat/manager/network/http_method_type.dart';
import 'package:pivot_chat/manager/network/pc_base_network_manager.dart';
import '../../model/example_model.dart';

class PCNetworkManager extends PCBaseNetworkManager {
  /// example
  Future<PCExampleModel?> getExample() => sendRequest(HttpMethodType.get, '/example', PCExampleModel.fromJson);

  Future<Map<String, Object>?> setExample(PCExampleModel model) => sendRequest(
        HttpMethodType.post,
        '/set_example',
        (data) => data,
        cmd: model.toJson(),
      );
}
