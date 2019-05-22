// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchPlaceholder _$SearchPlaceholderFromJson(Map json) {
  return SearchPlaceholder(
      json['discoverTab'] as String,
      json['recommendTab'] as String,
      json['subscribeTab'] as String,
      json['homeTab'] as String);
}

Map<String, dynamic> _$SearchPlaceholderToJson(SearchPlaceholder instance) =>
    <String, dynamic>{
      'discoverTab': instance.discoverTab,
      'recommendTab': instance.recommendTab,
      'subscribeTab': instance.subscribeTab,
      'homeTab': instance.homeTab
    };

CentralEntry _$CentralEntryFromJson(Map json) {
  return CentralEntry(json['picUrl'] as String, json['url'] as String,
      json['title'] as String, json['version'] as String);
}

Map<String, dynamic> _$CentralEntryToJson(CentralEntry instance) =>
    <String, dynamic>{
      'picUrl': instance.picUrl,
      'url': instance.url,
      'title': instance.title,
      'version': instance.version
    };
