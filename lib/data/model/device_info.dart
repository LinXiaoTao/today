import 'package:json_annotation/json_annotation.dart';

part 'device_info.g.dart';

@JsonSerializable()
class DeviceInfo {
  final String deviceId;
  final String osVersion;
  final String androidId;

  DeviceInfo({this.deviceId, this.osVersion, this.androidId});

  factory DeviceInfo.fromJson(Map json) => _$DeviceInfoFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceInfoToJson(this);
}
