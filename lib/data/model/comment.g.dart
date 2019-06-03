// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentList _$CommentListFromJson(Map json) {
  return CommentList(
      json['hasMoreHotComments'] as bool ?? false,
      (json['data'] as List)
              ?.map((e) => e == null ? null : Comment.fromJson(e as Map))
              ?.toList() ??
          [],
      (json['hotComments'] as List)
              ?.map((e) => e == null ? null : Comment.fromJson(e as Map))
              ?.toList() ??
          [],
      (json['loadMoreKey'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          ) ??
          {});
}

Map<String, dynamic> _$CommentListToJson(CommentList instance) =>
    <String, dynamic>{
      'hasMoreHotComments': instance.hasMoreHotComments,
      'data': instance.data,
      'hotComments': instance.hotComments,
      'loadMoreKey': instance.loadMoreKey
    };

Comment _$CommentFromJson(Map json) {
  return Comment(
      json['type'] as String,
      json['id'] as String,
      json['targetType'] as String,
      json['targetId'] as String ?? '',
      json['threadId'] as String ?? '',
      json['createdAt'] as String,
      json['level'] as int ?? 1,
      json['content'] as String ?? '',
      json['likeCount'] as int ?? 0,
      json['replyCount'] as int ?? 0,
      json['status'] as String,
      json['user'] == null ? null : UserInfo.fromJson(json['user'] as Map),
      (json['pictures'] as List)
              ?.map((e) => e == null ? null : Picture.fromJson(e as Map))
              ?.toList() ??
          [],
      json['liked'] as bool ?? false,
      (json['hotReplies'] as List)
              ?.map((e) => e == null ? null : Comment.fromJson(e as Map))
              ?.toList() ??
          [],
      json['replyToComment'] == null
          ? null
          : Comment.fromJson(json['replyToComment'] as Map),
      (json['urlsInText'] as List)
              ?.map((e) => e == null ? null : UrlsInText.fromJson(e as Map))
              ?.toList() ??
          []);
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
      'liked': instance.liked,
      'hotReplies': instance.hotReplies,
      'replyToComment': instance.replyToComment,
      'urlsInText': instance.urlsInText
    };
