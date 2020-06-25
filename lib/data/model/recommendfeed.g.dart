// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendfeed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendFeed _$RecommendFeedFromJson(Map json) {
  return RecommendFeed(
    (json['data'] as List)
            ?.map((e) => e == null ? null : Message.fromJson(e as Map))
            ?.toList() ??
        [],
    json['toastMessage'] as String ?? '',
    json['loadMoreKey'] == null
        ? null
        : LoadMoreKey.fromJson(json['loadMoreKey'] as Map),
  );
}

Map<String, dynamic> _$RecommendFeedToJson(RecommendFeed instance) =>
    <String, dynamic>{
      'data': instance.data,
      'toastMessage': instance.toastMessage,
      'loadMoreKey': instance.loadMoreKey,
    };

Flags _$FlagsFromJson(Map json) {
  return Flags(
    json['hideDismissIcon'] as bool ?? false,
    json['toggleFullscreen'] as bool ?? false,
  );
}

Map<String, dynamic> _$FlagsToJson(Flags instance) => <String, dynamic>{
      'hideDismissIcon': instance.hideDismissIcon,
      'toggleFullscreen': instance.toggleFullscreen,
    };

Button _$ButtonFromJson(Map json) {
  return Button(
    json['text'] as String ?? '',
    json['linkUrl'] as String ?? '',
  );
}

Map<String, dynamic> _$ButtonToJson(Button instance) => <String, dynamic>{
      'text': instance.text,
      'linkUrl': instance.linkUrl,
    };

LoadMoreKey _$LoadMoreKeyFromJson(Map json) {
  return LoadMoreKey(
    json['page'] as int,
    json['feedTime'] as int,
    json['stageKey'] == null
        ? null
        : LoadMoreStageKey.fromJson(json['stageKey'] as Map),
  );
}

Map<String, dynamic> _$LoadMoreKeyToJson(LoadMoreKey instance) =>
    <String, dynamic>{
      'page': instance.page,
      'feedTime': instance.feedTime,
      'stageKey': instance.stageKey,
    };

LoadMoreStageKey _$LoadMoreStageKeyFromJson(Map json) {
  return LoadMoreStageKey(
    json['stage'] as int,
    json['page'] as int,
  );
}

Map<String, dynamic> _$LoadMoreStageKeyToJson(LoadMoreStageKey instance) =>
    <String, dynamic>{
      'stage': instance.stage,
      'page': instance.page,
    };

RecommendHeadItem _$RecommendHeadItemFromJson(Map json) {
  return RecommendHeadItem(
    json['id'] as String,
    json['title'] as String,
    json['url'] as String,
    json['picUrl'] as String,
    json['type'] as String,
  );
}

Map<String, dynamic> _$RecommendHeadItemToJson(RecommendHeadItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'url': instance.url,
      'picUrl': instance.picUrl,
      'type': instance.type,
    };

DislikeMenu _$DislikeMenuFromJson(Map json) {
  return DislikeMenu(
    json['title'] as String,
    json['subtitle'] as String,
    (json['reasons'] as List)?.map((e) => e as Map)?.toList(),
  );
}

Map<String, dynamic> _$DislikeMenuToJson(DislikeMenu instance) =>
    <String, dynamic>{
      'title': instance.title,
      'subtitle': instance.subtitle,
      'reasons': instance.reasons,
    };
