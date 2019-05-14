import 'package:today/data/storage/simple_storage.dart';
import 'package:today/data/constants.dart';
import 'package:flutter/widgets.dart';

class LoginState {
  static bool isLogin = false;
  static String accessToken = "";
  static String deviceId = "";
  static String refreshToken = "";

  LoginState._();

  static init() async {
    accessToken = await SimpleStorage.getString(key_access_token);
    refreshToken = await SimpleStorage.getString(key_refresh_token);
    deviceId = await SimpleStorage.getString(key_device_id);
    isLogin = accessToken.isNotEmpty;
    debugPrint("登录状态：token = $accessToken; deviceId = $deviceId");
  }
}
