part of 'pc_base_network_manager.dart';

class _CustomInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.i('REQUEST[${options.method}] => PATH: ${options.path} DATA: ${options.data}');
    SmartDialog.dismiss(status: SmartStatus.loading, force: true);
    SmartDialog.showLoading();
    // if (tokenManager.isAuthed) {
    //   options.headers['token'] = tokenManager.token!;
    // }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    logger.i('RESPONSE[${response.statusCode}] <= PATH: ${response.requestOptions.path} DATA: ${response.data}');
    SmartDialog.dismiss(status: SmartStatus.loading);
    super.onResponse(response, handler);
  }

  @override
  Future<dynamic> onError(DioException err, ErrorInterceptorHandler handler) async {
    logger.i('ERROR[${err.response?.statusCode}] <= PATH: ${err.requestOptions.path} DATA: ${err.response?.data}');
    final response = err.response;
    SmartDialog.dismiss(status: SmartStatus.loading);
    if (response != null) {
      // if (response.statusCode == 401 && tokenManager.isAuthed) {
      //   SmartDialog.showToast('登录过期，请重新登录');
      //   tokenManager.setToken(null);
      //   return;
      // }
      handler.resolve(response);
    } else {
      SmartDialog.showToast('网络错误');
      super.onError(err, handler);
    }
  }
}
