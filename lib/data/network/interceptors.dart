import 'package:dio/dio.dart';
import 'package:today/data/storage/simple_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:today/data/constants.dart';
import 'package:today/data/state/login.dart';

/// 业务拦截器

class BusinessInterceptor implements Interceptor {
  @override
  onError(DioError err) {
    debugPrint(
        "net error: url = ${err.request.uri.toString()}, msg = ${err.message}");
    return err;
  }

  @override
  onRequest(RequestOptions options) {
    /// token
    options.headers[key_access_token] = LoginState.accessToken;
    return options;
  }

  @override
  onResponse(Response response) {
    debugPrint("net response: $response");
    if (response.headers.value(key_access_token) != null) {
      String token = response.headers.value(key_access_token);
      debugPrint("key_access_token: $token");
      SimpleStorage.putString(key_access_token, token);
    }

    if (response.headers.value(key_refresh_token) != null) {
      String token = response.headers.value(key_refresh_token);
      debugPrint("key_refresh_token: $token");
      SimpleStorage.putString(key_refresh_token, token);
    }

    return response;
  }
}
