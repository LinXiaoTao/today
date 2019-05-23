// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map json) {
  return Comment(
      json['type'] as String,
      json['id'] as String,
      json['targetType'] as String,
      json['targetId'] as String,
      json['threadId'] as String,
      json['createdAt'] as String,
      json['level'] as int,
      json['content'] as String,
      json['likeCount'] as int,
      json['replyCount'] as int,
      json['status'] as String,
      json['user'] == null ? null : UserInfo.fromJson(json['user'] as Map),
      (json['pictures'] as List)
              ?.map((e) => e == null ? null : Picture.fromJson(e as Map))
              ?.toList() ??
          [],
      json['liked'] as bool);
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'targetType': instance.targetType,
      'targetId': instance.targetId,
      'threadId': instance.threadId,
      'createdAt': instance.createdAt,
      'level': instance.level,
      'content': instance.content,
      'likeCount': instance.likeCount,
      'replyCount': instance.replyCount,
      'status': instance.status,
      'user': instance.user,
      'pictures': instance.pictures,
      'liked': instance.liked
    };
