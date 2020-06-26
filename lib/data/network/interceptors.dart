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
  static int _refreshTokenError = 0;

  @override
  onError(DioError error) async {
    debugPrint(
        "net error: url = ${error.request.uri.toString()}, msg = ${error.message}");
    return _handleError(error);
  }

  @override
  onRequest(RequestOptions options) async {
    /// token
    if (LoginUserState.accessToken.isNotEmpty) {
      options.headers[key_access_token] = LoginUserState.accessToken;
    }
    return options;
  }

  @override
  onResponse(Response response) async {
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

  Future _handleError(error) async {
    if (error is DioError) {
      DioError dioError = error;
      if (dioError.response.statusCode == 401) {
        /// 登录失效，刷新 token
        if (_refreshToken) {
          debugPrint("token 失效，但已经在刷新 token 中了");
          return error;
        }
        if (_refreshTokenError > 10) {
          debugPrint('获取 token 失败过多，不再刷新 token 了');
          return error;
        }
        _refreshToken = true;
        ApiRequest.refreshToken().then((value) async {
          _refreshToken = false;
          debugPrint("失效刷新 token: $value");
          if (value) {
            /// 刷新缓存
            _refreshTokenError = 0;
            await LoginUserState.init();
          }
        }).catchError((value) {
          _refreshToken = false;
          _refreshTokenError++;
        });
      } else if (dioError.response.statusCode == 400) {
        // 提示业务错误信息
        return dioError.response;
      }
      return error;
    }
  }
}
