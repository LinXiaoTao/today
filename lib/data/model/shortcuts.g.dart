// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shortcuts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShortcutsData _$ShortcutsDataFromJson(Map json) {
  return ShortcutsData(
      json['title'] as String,
      json['recommendCount'] as int,
      (json['shortcuts'] as List)
          ?.map((e) => e == null ? null : Shortcut.fromJson(e as Map))
          ?.toList());
}

Map<String, dynamic> _$ShortcutsDataToJson(ShortcutsData instance) =>
    <String, dynamic>{
      'title': instance.title,
      'recommendCount': instance.recommendCount,
      'shortcuts': instance.shortcuts
    };

Shortcut _$ShortcutFromJson(Map json) {
  return Shortcut(
      json['id'] as String,
      json['type'] as String,
      json['contentType'] as String,
      json['content'] as String,
      json['url'] as String,
      json['picUrl'] as String,
      json['style'] as String ?? '');
}

Map<String, dynamic> _$ShortcutToJson(Shortcut instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'contentType': instance.contentType,
      'content': instance.content,
      'url': instance.url,
      'picUrl': instance.picUrl,
      'style': instance.style
    };
