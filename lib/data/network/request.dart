import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:today/data/storage/simple_storage.dart';
import 'package:today/data/network/interceptors.dart';
import 'package:today/data/constants.dart';
import 'package:uuid/uuid.dart';
import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:today/data/model/models.dart';
export 'package:today/data/model/models.dart';
import 'package:today/data/state/login.dart';
import 'dart:async';

class ApiRequest {
  static Dio _dio;

  static bool _init = false;

  ApiRequest._();

  static String _saDeviceId;

  /// 注册
  static Future<UserInfo> register() async {
    /// 游客登录，用户名和密码是随机生成的

    return _dio.post("/1.0/users/register", data: {
      "username": Uuid().v4(),
      "password": _generaPassword()
    }).then((value) {
      Map<String, dynamic> data = value.data;
      if (data["success"]) {
        SimpleStorage.putString(key_saDevice_id, _saDeviceId);
        return UserInfo.fromJson(data["user"]);
      }
      throw "register request fail";
    });
  }

  /// 获取用户数据
  static Future<UserProfile> profile({String username = ''}) async {
    Map<String, dynamic> query = {};
    if (username.isNotEmpty) {
      query['username'] = username;
    }
    return _dio.get("/1.0/users/profile", queryParameters: query).then((value) {
      return UserProfile.fromJson(value.data);
    }).catchError((error) {
      debugPrint("error = $error");
    });
  }

  /// 保存设备信息
  static Future<bool> saveDeviceInfo() async {
    return _dio.post("/1.0/users/saveDeviceInfo", data: {
      "instanceid": _saDeviceId,
      "imei": "",
      "guid": LoginState.deviceId
    }).then((value) {
      return value.data["success"];
    });
  }

  /// 推荐数据
  static Future<RecommendFeed> recommendFeedList(
      {LoadMoreKey loadMoreKey}) async {
    Map requestData = {"trigger": "user"};

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
  static Future<Message> originalPostsGet(String id,
      {String userRef = '', String topicRef = ''}) {
    Map<String, dynamic> queryParameters = {'id': id};

    if (userRef != null && userRef.isNotEmpty) {
      queryParameters['userRef'] = userRef;
    }

    if (topicRef != null && topicRef.isNotEmpty) {
      queryParameters['topicRef'] = topicRef;
    }

    return _dio
        .get('/1.0/originalPosts/get', queryParameters: queryParameters)
        .then((value) {
      return Message.fromJson(value.data['data']);
    });
  }

  /// 官方消息
  static Future<Message> officialMessages(
    String id,
  ) {
    return _dio.get('/1.0/officialMessages/get',
        queryParameters: {'id': id}).then((value) {
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

  static Future<List<Message>> officialListRelated(String id,
      {String pageName}) {
    Map<String, dynamic> queryParameters = {'id': id};
    if (pageName != null) {
      queryParameters['pageName'] = pageName;
    }

    return _dio
        .get('/1.0/officialMessages/listRelated',
            queryParameters: queryParameters)
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

  /// 评论详情
  static Future<Comment> commentDetail(String id, String targetType) {
    return _dio.get('/1.0/comments/get',
        queryParameters: {'id': id, 'targetType': targetType}).then((value) {
      return Comment.fromJson(value.data['data']);
    });
  }

  /// 评论回复列表
  static Future<CommentList> replyCommentList(
      String primaryCommentId, String targetType,
      {String order = 'LIKES', Map loadMoreKey}) {
    Map data = {
      'primaryCommentId': primaryCommentId,
      'targetType': targetType,
      'order': order,
    };

    if (loadMoreKey != null) {
      data['loadMoreKey'] = loadMoreKey;
    }

    return _dio.post('/1.0/comments/list', data: data).then((value) {
      return CommentList.fromJson(value.data);
    });
  }

  static Future<Map> mediaMeta(Map<String, dynamic> query) {
    return _dio
        .post('/1.0/mediaMeta/interactive', queryParameters: query)
        .then((value) {
      return value.data;
    });
  }

  static Future<List<Message>> relatedVideo(String id,
      {String type = 'ORIGINAL_POST'}) {
    return _dio.post('/1.0/related/video', data: {'id': id, 'type': type}).then(
        (value) {
      return (value.data['data'] as List).map((item) {
        return Message.fromJson(item);
      }).toList();
    });
  }

  static Future<PersonalUpdate> personalUpdates(String username,
      {int limit = 25, Map loadMoreKey}) {
    final data = {'username': username, 'limit': limit};
    if (loadMoreKey != null) {
      data['loadMoreKey'] = loadMoreKey;
    }
    return _dio.post('/1.0/personalUpdate/single', data: data).then((value) {
      return PersonalUpdate.fromJson(value.data);
    });
  }

  static Future<List<TopicTab>> topicListTabs() async {
    return _dio.get('/1.0/topics/discovery/listTabs').then((value) {
      List data = value.data['data'];
      return data.map((item) {
        return TopicTab.fromJson(item);
      }).toList();
    });
  }

  static Future<TopicList> topicListTopics(
      {int loadMoreKey = -1, String type = 'recommendation'}) async {
    Map<String, dynamic> data = {'type': type};
    if (loadMoreKey != -1) {
      data['loadMoreKey'] = loadMoreKey;
    }

    return _dio
        .post('/1.0/topics/discovery/listTopics', data: data)
        .then((value) {
      return TopicList.fromJson(value.data);
    });
  }

  static Future<bool> changeSubscriptionState(
      {String topicObjectId,
      bool subscribed,
      String ref,
      String pageName,
      bool push = true}) async {
    return _dio.post('/1.0/users/topics/changeSubscriptionStatus', data: {
      'topicObjectId': topicObjectId,
      'subscribed': subscribed,
      'ref': ref,
      'pageName': pageName,
      'push': push
    }).then((value) {
      return value.data['success'];
    });
  }

  static initDio() async {
    if (_init) return;
    String deviceId = await SimpleStorage.getString(key_device_id);

    /// 跟设备有一定关系
    _saDeviceId = await SimpleStorage.getString(key_saDevice_id);
    if (deviceId.isEmpty) {
      /// deviceId 也是随机生成的
      deviceId = _generaDeviceId();
      SimpleStorage.putString(key_device_id, deviceId);
    }
    if (_saDeviceId.isEmpty) {
      _saDeviceId = _generaDeviceId();
    }
    _dio = Dio(BaseOptions(baseUrl: "https://api.ruguoapp.com", headers: {
      "user-agent": "okhttp/4.7.2",
      "x-jike-app-id": "XeITUMa6kGKF",
      'applicationid': 'com.ruguoapp.jike',
      "app-version": "7.1.0",
      "app-buildno": "1065",
      "os-versio": 26,
      "content-type": "application/json",
      'manufacturer': 'HUAWEI',
      'model': 'BLN-AL10',
      'os': 'Android',
      'resolution': '1080x1800',
      'market': 'debug',
      "app-permissions": 4,
      'source': '',
      'x-jike-device-properties':
          json.encode({'uuid': _saDeviceId, 'android_id': deviceId})
    }));

    // proxy
    if (!const bool.fromEnvironment('dart.vm.product')) {
      // 不是 release，可设置代理
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (url) {
          return "PROXY 192.168.2.103:8888";
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

    if (!LoginState.isLogin) {
      final userInfo = await register();
      debugPrint("注册成功：${userInfo.username}");
      SimpleStorage.putString(key_username, userInfo.username);
      await LoginState.init();
    }

    /// 刷新 token
    bool value = await refreshToken();
    debugPrint("启动刷新 token: $value");
    if (value) {
      /// 刷新缓存
      await LoginState.init();
    }

    /// 异步获取当前用户数据
    profile();

    _scheduleRefreshTokenTask();
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

  /// 生成 deviceId
  static _generaDeviceId() {
    return Uuid().v4();
  }

  /// 定时刷新 token
  static _scheduleRefreshTokenTask() {
    Timer.periodic(Duration(minutes: 10), (timer) async {
      /// 刷新 token
      bool value = await refreshToken();
      debugPrint("定时刷新 token: $value");
      if (value) {
        /// 刷新缓存
        await LoginState.init();
      }
    });
  }
}
