import 'dart:io';

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
import 'dart:async';

class ApiRequest {
  static Dio _dio;

  static bool _init = false;

  ApiRequest._();

  static String _androidId;

  /// 注册
  static Future<UserInfo> register() async {
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
    return _dio.get("/1.0/users/profile").then((value) {
      return UserInfo.fromJson(value.data["user"]);
    });
  }

  /// 保存设备信息
  static Future<bool> saveDeviceInfo() async {
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
      requestData['loadMoreKey'] = loadMoreKey;
    }

    return _dio
        .post("/1.0/recommendFeed/list", data: requestData)
        .then((value) {
      return RecommendFeed.fromJson(value.data);
    });
  }

  /// 我的圈子
  static Future<ShortcutsData> shortcutsList() async {
    return _dio.get('/1.0/shortcuts/list').then((value) {
      return ShortcutsData.fromJson(value.data['data']);
    });
  }

  /// 搜索 placeholder
  static Future<SearchPlaceholder> searchPlaceholder() async {
    return _dio.post('/1.0/configs/appGet', data: {
      'keys': ['searchPlaceholder']
    }).then((value) {
      return SearchPlaceholder.fromJson(
          value.data['data']['searchPlaceholder']);
    });
  }

  /// 发布按钮样式
  static Future<CentralEntry> centralEntry() async {
    return _dio.post('/1.0/configs/appGet', data: {
      'keys': ['centralEntry']
    }).then((value) {
      return CentralEntry.fromJson(value.data['data']['centralEntry']);
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

  /// 消息详情
  static Future<Message> originalPostsGet(String id, {String userRef = ''}) {
    return _dio.get('/1.0/originalPosts/get',
        queryParameters: {'id': id, 'userRef': userRef}).then((value) {
      return Message.fromJson(value.data['data']);
    });
  }

  /// 相关消息
  static Future<List<Message>> listRelated(String id, {String pageName}) {
    Map<String, dynamic> queryParameters = {'id': id};
    if (pageName != null) {
      queryParameters['pageName'] = pageName;
    }

    return _dio
        .get('/1.0/originalPosts/listRelated', queryParameters: queryParameters)
        .then((value) {
      return (value.data['data'] as List).map((item) {
        return Message.fromJson(item);
      }).toList();
    });
  }

  /// 评论列表
  static Future<CommentList> commentList(String targetId, String targetType,
      {Map loadMoreKey}) {
    Map<String, dynamic> param = {
      'targetId': targetId,
      'targetType': targetType,
    };

    if (loadMoreKey != null) {
      param['loadMoreKey'] = loadMoreKey;
    }

    return _dio.post('/1.0/comments/listPrimary', data: param).then((value) {
      return CommentList.fromJson(value.data);
    });
  }

  static initDio() async {
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

    /// proxy
    if (!const bool.fromEnvironment('dart.vm.product')) {
      /// 不是 release
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (url) {
          return "PROXY 172.21.12.127:8888";
        };
        //抓Https包设置
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };
    }

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
}
