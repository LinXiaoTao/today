import 'package:dio/dio.dart';
import 'package:today/platform/app.dart';
import 'package:today/data/storage/simple_storage.dart';
import 'package:today/data/network/interceptors.dart';
import 'package:today/data/constants.dart';
import 'package:uuid/uuid.dart';
import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:today/data/model/init.dart';
export 'package:today/data/model/init.dart';
import 'package:today/data/state/login.dart';
import 'package:today/util/global.dart';
import 'package:today/data/event/events.dart';

class ApiRequest {
  static Dio _dio;

  static bool _init = false;

  static bool _refreshToken = false;

  ApiRequest._();

  static String _androidId;

  /// 注册
  static Future<UserInfo> register() async {
    await _initDio();

    /// 游客登录，用户名和密码是随机生成的
    return _dio.post("/1.0/users/register", data: {
      "saDeviceId": _androidId,
      "username": Uuid().v4(),
      "password": _generaPassword()
    }).then((value) {
      Map<String, dynamic> data = value.data;
      if (data["success"]) {
        SimpleStorage.putString(key_android_id, _androidId);
        return UserInfo.fromJson(data["user"]);
      }
      throw "register request fail";
    });
  }

  /// 获取用户数据
  static Future<UserInfo> profile() async {
    await _initDio();

    return _dio.get("/1.0/users/profile").then((value) {
      return UserInfo.fromJson(value.data["user"]);
    }).catchError((error) {
      _handleError(error);
      throw error;
    });
  }

  /// 保存设备信息
  static Future<bool> saveDeviceInfo() async {
    await _initDio();

    return _dio.post("/1.0/users/saveDeviceInfo", data: {
      "instanceid": _androidId,
      "imei": "",
      "guid": LoginState.deviceId
    }).then((value) {
      return value.data["success"];
    });
  }

  /// 推荐数据
  static Future<RecommendFeed> recommendFeedList(
      {LoadMoreKey loadMoreKey}) async {
    var requestData = {"debug": false, "trigger": "user"};

    if (loadMoreKey != null) {
      requestData["score"] = loadMoreKey.score;
    }

    return _dio.post("/1.0/recommendFeed/list", data: {}).then((value) {
      return RecommendFeed.fromJson(value.data);
    });
  }

  /// 刷新 token
  static Future<bool> refreshToken() async {
    return _dio
        .get("/1.0/app_auth_tokens.refresh",
            options:
                Options(headers: {key_refresh_token: LoginState.refreshToken}))
        .then((value) {
      return value.data["success"];
    });
  }

  static _initDio() async {
    if (_init) return;

    String deviceId = await SimpleStorage.getString(key_device_id);
    DeviceInfo deviceInfo = await AppPlatform.getDeviceInfo();

    /// 跟设备有一定关系
    _androidId = await SimpleStorage.getString(key_android_id);
    if (deviceId.isEmpty) {
      /// deviceId 也是随机生成的
      deviceId = deviceInfo.deviceId;
      SimpleStorage.putString(key_device_id, deviceId);
    }
    if (_androidId.isEmpty) {
      _androidId = deviceInfo.androidId;
    }
    _dio = Dio(BaseOptions(baseUrl: "https://app.jike.ruguoapp.com", headers: {
      "user-agent": "okhttp/3.13.1",
      "applicationid": "com.ruguoapp.jike",
      "notification-status": "ON",
      "app-version": "5.8.1",
      "app-buildno": "828",
      "os-version": deviceInfo.osVersion,
      "Content-Type": "application/json",
      key_device_id: deviceId
    }));

    /// business
    _dio.interceptors.add(BusinessInterceptor());
    _init = true;
    debugPrint("init success");
  }

  /// 生成随机密码
  static String _generaPassword() {
    String password = "";
    Random random = Random();
    for (var index = 0; index < 16; index++) {
      password +=
          "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"[
              random.nextInt(62)];
    }
    debugPrint("genera password: $password");
    return password;
  }

  static _handleError(error) {
    if (error is DioError) {
      DioError dioError = error;
      if (dioError.response.statusCode == 401) {
        /// 登录失效，刷新 token
        if (_refreshToken) {
          debugPrint("token 失效，但已经在刷新 token 中了");
          return;
        }
        _refreshToken = true;
        refreshToken().then((value) async {
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
    } else {}
  }
}
