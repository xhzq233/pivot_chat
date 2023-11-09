part of 'pc_base_network_manager.dart';

class _CustomInterceptors extends Interceptor {
  _CustomInterceptors(this.tokenGetter);

  TokenGetter tokenGetter;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.i(_tag, 'REQUEST[${options.method}] => PATH: ${options.path} DATA: ${options.data}');
    SmartDialog.dismiss(status: SmartStatus.loading, force: true);
    SmartDialog.showLoading();
    final token = tokenGetter.getToken();
    if (token != null) options.headers['token'] = token;
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    logger.i(_tag, 'RESPONSE[${response.statusCode}] <= PATH: ${response.requestOptions.path} DATA: ${response.data}');
    SmartDialog.dismiss(status: SmartStatus.loading);
    super.onResponse(response, handler);
  }

  @override
  Future<dynamic> onError(DioException err, ErrorInterceptorHandler handler) async {
    logger.i(
        _tag, 'ERROR[${err.response?.statusCode}] <= PATH: ${err.requestOptions.path} DATA: ${err.response?.data}');
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
