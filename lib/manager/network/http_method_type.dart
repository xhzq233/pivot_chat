enum HttpMethodType {
  get,
  post,
  put,
  delete,
  patch;

  String get name {
    switch (this) {
      case HttpMethodType.get:
        return 'GET';
      case HttpMethodType.post:
        return 'POST';
      case HttpMethodType.put:
        return 'PUT';
      case HttpMethodType.delete:
        return 'DELETE';
      case HttpMethodType.patch:
        return 'PATCH';
      default:
        throw UnsupportedError('Unsupported method type: $this');
    }
  }
}
