class NetworkConfig {
  static String baseUrl = '';
  static Map<String, dynamic> defaultHeaders = {};
  static Duration connectTimeout = const Duration(seconds: 10);
  static Duration receiveTimeout = const Duration(seconds: 10);

  static void update({
    String? baseUrl,
    Map<String, dynamic>? headers,
    Duration? connectTimeout,
    Duration? receiveTimeout,
  }) {
    if (baseUrl != null) NetworkConfig.baseUrl = baseUrl;
    if (headers != null) NetworkConfig.defaultHeaders = headers;
    if (connectTimeout != null) NetworkConfig.connectTimeout = connectTimeout;
    if (receiveTimeout != null) NetworkConfig.receiveTimeout = receiveTimeout;
  }
}