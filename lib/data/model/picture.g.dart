// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'picture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Picture _$PictureFromJson(Map json) {
  return Picture(
      json['thumbnailUrl'] as String,
      json['middlePicUrl'] as String,
      json['picUrl'] as String,
      json['format'] as String ?? '',
      json['averageHue'] as String,
      width: json['width'] as int ?? 0,
      height: json['height'] as int ?? 0);
}

Map<String, dynamic> _$PictureToJson(Picture instance) => <String, dynamic>{
      'thumbnailUrl': instance.thumbnailUrl,
      'middlePicUrl': instance.middlePicUrl,
      'picUrl': instance.picUrl,
      'format': instance.format,
      'averageHue': instance.averageHue,
      'width': instance.width,
      'height': instance.height
    };
