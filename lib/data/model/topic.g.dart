// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopicList _$TopicListFromJson(Map json) {
  return TopicList(
      json['loadMoreKey'] as int ?? -1,
      (json['data'] as List)
              ?.map((e) => e == null ? null : Topic.fromJson(e as Map))
              ?.toList() ??
          []);
}

Map<String, dynamic> _$TopicListToJson(TopicList instance) => <String, dynamic>{
      'loadMoreKey': instance.loadMoreKey,
      'data': instance.data
    };

Topic _$TopicFromJson(Map json) {
  return Topic(
      json['id'] as String ?? '',
      json['type'] as String ?? '',
      json['messagePrefix'] as String ?? '',
      json['topicId'] as int ?? 0,
      json['content'] as String ?? '',
      json['timeForRank'] as String ?? '',
      json['lastMessagePostTime'] as String ?? '',
      json['isAnonymous'] as bool ?? false,
      json['isDreamTopic'] as bool ?? false,
      json['createdAt'] as String ?? '',
      json['updatedAt'] as String ?? '',
      json['subscribersCount'] as int ?? 0,
      json['subscribedStatusRawValue'] as int ?? 0,
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
      json['squarePostUpdateTime'] as String,
      json['subscribersName'] as String,
      json['subscribersAction'] as String,
      json['subscribersTextSuffix'] as String,
      json['subscribersDescription'] as String,
      json['intro'] as String,
      json['ref'] as String ?? '',
      json['involvedUsers'] == null
          ? null
          : InvolvedUsers.fromJson(json['involvedUsers'] as Map));
}

Map<String, dynamic> _$TopicToJson(Topic instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'messagePrefix': instance.messagePrefix,
      'topicId': instance.topicId,
      'content': instance.content,
      'timeForRank': instance.timeForRank,
      'lastMessagePostTime': instance.lastMessagePostTime,
      'isAnonymous': instance.isAnonymous,
      'isDreamTopic': instance.isDreamTopic,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'subscribersCount': instance.subscribersCount,
      'subscribedStatusRawValue': instance.subscribedStatusRawValue,
      'approximateSubscribersCount': instance.approximateSubscribersCount,
      'briefIntro': instance.briefIntro,
      'squarePicture': instance.squarePicture,
      'enablePictureComments': instance.enablePictureComments,
      'enablePictureWatermark': instance.enablePictureWatermark,
      'isValid': instance.isValid,
      'topicType': instance.topicType,
      'operateStatus': instance.operateStatus,
      'isCommentForbidden': instance.isCommentForbidden,
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

TopicTab _$TopicTabFromJson(Map json) {
  return TopicTab(json['name'] as String ?? '', json['alias'] as String ?? '');
}

Map<String, dynamic> _$TopicTabToJson(TopicTab instance) =>
    <String, dynamic>{'name': instance.name, 'alias': instance.alias};
