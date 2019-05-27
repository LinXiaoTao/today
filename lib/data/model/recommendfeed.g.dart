// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendfeed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendFeed _$RecommendFeedFromJson(Map json) {
  return RecommendFeed(
      (json['data'] as List)
              ?.map((e) => e == null ? null : RecommendItem.fromJson(e as Map))
              ?.toList() ??
          [],
      json['toastMessage'] as String ?? '',
      json['loadMoreKey'] == null
          ? null
          : LoadMoreKey.fromJson(json['loadMoreKey'] as Map));
}

Map<String, dynamic> _$RecommendFeedToJson(RecommendFeed instance) =>
    <String, dynamic>{
      'data': instance.data,
      'toastMessage': instance.toastMessage,
      'loadMoreKey': instance.loadMoreKey
    };

RecommendItem _$RecommendItemFromJson(Map json) {
  return RecommendItem(
      (json['items'] as List)
          ?.map((e) => e == null ? null : RecommendHeadItem.fromJson(e as Map))
          ?.toList(),
      json['type'] as String,
      json['id'] as String,
      json['item'] == null ? null : Message.fromJson(json['item'] as Map),
      json['dislikeMenu'] == null
          ? null
          : DislikeMenu.fromJson(json['dislikeMenu'] as Map),
      json['action'] as String ?? '',
      json['text'] as String ?? '');
}

Map<String, dynamic> _$RecommendItemToJson(RecommendItem instance) =>
    <String, dynamic>{
      'items': instance.items,
      'type': instance.type,
      'id': instance.id,
      'item': instance.item,
      'dislikeMenu': instance.dislikeMenu,
      'action': instance.action,
      'text': instance.text
    };

LoadMoreKey _$LoadMoreKeyFromJson(Map json) {
  return LoadMoreKey(
      json['score'] as int, json['isLastPage'] as bool, json['page'] as int);
}

Map<String, dynamic> _$LoadMoreKeyToJson(LoadMoreKey instance) =>
    <String, dynamic>{
      'score': instance.score,
      'isLastPage': instance.isLastPage,
      'page': instance.page
    };

RecommendHeadItem _$RecommendHeadItemFromJson(Map json) {
  return RecommendHeadItem(json['id'] as String, json['title'] as String,
      json['url'] as String, json['picUrl'] as String, json['type'] as String);
}

Map<String, dynamic> _$RecommendHeadItemToJson(RecommendHeadItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'url': instance.url,
      'picUrl': instance.picUrl,
      'type': instance.type
    };

DislikeMenu _$DislikeMenuFromJson(Map json) {
  return DislikeMenu(json['title'] as String, json['subtitle'] as String,
      (json['reasons'] as List)?.map((e) => e as Map)?.toList());
}

Map<String, dynamic> _$DislikeMenuToJson(DislikeMenu instance) =>
    <String, dynamic>{
      'title': instance.title,
      'subtitle': instance.subtitle,
      'reasons': instance.reasons
    };
