// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendfeed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendFeed _$RecommendFeedFromJson(Map json) {
  return RecommendFeed(
      (json['data'] as List)
          ?.map((e) => e == null ? null : RecommendItem.fromJson(e as Map))
          ?.toList(),
      json['toastMessage'] as String,
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
      json['item'] == null
          ? null
          : RecommendBodyItem.fromJson(json['item'] as Map),
      json['dislikeMenu'] == null
          ? null
          : DislikeMenu.fromJson(json['dislikeMenu'] as Map));
}

Map<String, dynamic> _$RecommendItemToJson(RecommendItem instance) =>
    <String, dynamic>{
      'items': instance.items,
      'type': instance.type,
      'id': instance.id,
      'item': instance.item,
      'dislikeMenu': instance.dislikeMenu
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

RecommendBodyItem _$RecommendBodyItemFromJson(Map json) {
  return RecommendBodyItem(
      json['id'] as String,
      json['type'] as String,
      json['content'] as String,
      (json['urlsInText'] as List)
          ?.map((e) => e == null ? null : UrlsInText.fromJson(e as Map))
          ?.toList(),
      json['status'] as String,
      json['isCommentForbidden'] as bool,
      json['likeCount'] as int,
      json['commentCount'] as int,
      json['repostCount'] as int,
      json['shareCount'] as int,
      json['topic'] == null ? null : Topic.fromJson(json['topic'] as Map),
      (json['pictures'] as List)
          ?.map((e) => e == null ? null : Picture.fromJson(e as Map))
          ?.toList(),
      json['user'] == null ? null : UserInfo.fromJson(json['user'] as Map),
      json['createdAt'] as String,
      json['messageId'] as String,
      json['video'] == null ? null : Video.fromJson(json['video'] as Map),
      json['subtitle'] as String,
      json['topComment'] == null
          ? null
          : Comment.fromJson(json['topComment'] as Map),
      (json['attachedComments'] as List)
          ?.map((e) => e == null ? null : Comment.fromJson(e as Map))
          ?.toList(),
      json['viewType'] as String);
}

Map<String, dynamic> _$RecommendBodyItemToJson(RecommendBodyItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'content': instance.content,
      'urlsInText': instance.urlsInText,
      'status': instance.status,
      'isCommentForbidden': instance.isCommentForbidden,
      'likeCount': instance.likeCount,
      'commentCount': instance.commentCount,
      'repostCount': instance.repostCount,
      'shareCount': instance.shareCount,
      'topic': instance.topic,
      'pictures': instance.pictures,
      'user': instance.user,
      'createdAt': instance.createdAt,
      'messageId': instance.messageId,
      'video': instance.video,
      'subtitle': instance.subtitle,
      'topComment': instance.topComment,
      'attachedComments': instance.attachedComments,
      'viewType': instance.viewType
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

Topic _$TopicFromJson(Map json) {
  return Topic(
      json['id'] as String,
      json['type'] as String,
      json['content'] as String,
      json['subscribersCount'] as int,
      json['approximateSubscribersCount'] as String,
      json['briefIntro'] as String,
      json['squarePicture'] == null
          ? null
          : Picture.fromJson(json['squarePicture'] as Map),
      json['enablePictureComments'] as bool,
      json['enablePictureWatermark'] as bool,
      json['isValid'] as bool,
      json['topicType'] as String,
      json['operateStatus'] as String,
      json['isCommentForbidden'] as bool,
      json['lastMessagePostTime'] as String,
      json['squarePostUpdateTime'] as String,
      json['subscribersName'] as String,
      json['subscribersAction'] as String,
      json['subscribersTextSuffix'] as String,
      json['subscribersDescription'] as String,
      json['intro'] as String,
      json['ref'] as String,
      json['involvedUsers'] == null
          ? null
          : InvolvedUsers.fromJson(json['involvedUsers'] as Map));
}

Map<String, dynamic> _$TopicToJson(Topic instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'content': instance.content,
      'subscribersCount': instance.subscribersCount,
      'approximateSubscribersCount': instance.approximateSubscribersCount,
      'briefIntro': instance.briefIntro,
      'squarePicture': instance.squarePicture,
      'enablePictureComments': instance.enablePictureComments,
      'enablePictureWatermark': instance.enablePictureWatermark,
      'isValid': instance.isValid,
      'topicType': instance.topicType,
      'operateStatus': instance.operateStatus,
      'isCommentForbidden': instance.isCommentForbidden,
      'lastMessagePostTime': instance.lastMessagePostTime,
      'squarePostUpdateTime': instance.squarePostUpdateTime,
      'subscribersName': instance.subscribersName,
      'subscribersAction': instance.subscribersAction,
      'subscribersTextSuffix': instance.subscribersTextSuffix,
      'subscribersDescription': instance.subscribersDescription,
      'intro': instance.intro,
      'ref': instance.ref,
      'involvedUsers': instance.involvedUsers
    };

InvolvedUsers _$InvolvedUsersFromJson(Map json) {
  return InvolvedUsers((json['users'] as List)
      ?.map((e) => e == null ? null : UserInfo.fromJson(e as Map))
      ?.toList());
}

Map<String, dynamic> _$InvolvedUsersToJson(InvolvedUsers instance) =>
    <String, dynamic>{'users': instance.users};

UrlsInText _$UrlsInTextFromJson(Map json) {
  return UrlsInText(json['title'] as String, json['originalUrl'] as String,
      json['url'] as String, json['type'] as String);
}

Map<String, dynamic> _$UrlsInTextToJson(UrlsInText instance) =>
    <String, dynamic>{
      'title': instance.title,
      'originalUrl': instance.originalUrl,
      'url': instance.url,
      'type': instance.type
    };
