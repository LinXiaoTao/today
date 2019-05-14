// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Video _$VideoFromJson(Map json) {
  return Video(
      json['type'] as String,
      json['image'] == null ? null : Picture.fromJson(json['image'] as Map),
      json['duration'] as int,
      json['width'] as int,
      json['height'] as int);
}

Map<String, dynamic> _$VideoToJson(Video instance) => <String, dynamic>{
      'type': instance.type,
      'image': instance.image,
      'duration': instance.duration,
      'width': instance.width,
      'height': instance.height
    };
