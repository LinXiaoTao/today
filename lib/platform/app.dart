import 'dart:async';
import 'package:flutter/services.dart';
import 'package:today/data/model/device_info.dart';
export 'package:today/data/model/device_info.dart';

class AppPlatform {
  static const _platform = const MethodChannel("com.leo.personal.today/app");

  AppPlatform._();

  static Future<DeviceInfo> getDeviceInfo() {
    return _platform.invokeMethod("getDeviceInfo").then((value) {
      if (value["status"] != 1) {
        throw "error status: ${value["status"]}";
      }
      return DeviceInfo.fromJson(value["data"]);
    });
  }
}
