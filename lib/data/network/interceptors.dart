import 'package:dio/dio.dart';
import 'package:today/data/event/events.dart';
import 'package:today/data/storage/simple_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:today/data/constants.dart';
import 'package:today/data/state/login.dart';
import 'package:today/data/network/request.dart';
import 'package:today/util/global.dart';

/// 业务拦截器

class BusinessInterceptor implements Interceptor {
  static bool _refreshToken = false;

  @override
  onError(DioError error) {
    debugPrint(
        "net error: url = ${error.request.uri.toString()}, msg = ${error.message}");
    _handleError(error);
    return error;
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

  _handleError(error) {
    if (error is DioError) {
      DioError dioError = error;
      if (dioError.response.statusCode == 401) {
        /// 登录失效，刷新 token
        if (_refreshToken) {
          debugPrint("token 失效，但已经在刷新 token 中了");
          return;
        }
        _refreshToken = true;
        ApiRequest.refreshToken().then((value) async {
          _refreshToken = false;
          debugPrint("刷新 token: $value");
          if (value) {
            /// 刷新缓存
            await LoginState.init();
            Global.eventBus.fire(RefreshTokenEvent());
          }
        }).catchError((value) {
          _refreshToken = false;
          return false;
        });
      }
    }
  }
}
