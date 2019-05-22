// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
