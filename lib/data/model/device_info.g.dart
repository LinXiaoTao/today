// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceInfo _$DeviceInfoFromJson(Map json) {
  return DeviceInfo(
      deviceId: json['deviceId'] as String,
      osVersion: json['osVersion'] as String,
      androidId: json['androidId'] as String);
}

Map<String, dynamic> _$DeviceInfoToJson(DeviceInfo instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'osVersion': instance.osVersion,
      'androidId': instance.androidId
    };
