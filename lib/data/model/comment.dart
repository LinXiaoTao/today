import 'package:json_annotation/json_annotation.dart';
import 'package:today/data/model/user.dart';
import 'package:today/data/model/picture.dart';

part 'comment.g.dart';

@JsonSerializable()
class CommentList {
  @JsonKey(defaultValue: false)
  final bool hasMoreHotComments;
  @JsonKey(defaultValue: [])
  final List<Comment> data;
  @JsonKey(defaultValue: [])
  final List<Comment> hotComments;
  @JsonKey(defaultValue: {})
  final Map<String, dynamic> loadMoreKey;

  CommentList(
      this.hasMoreHotComments, this.data, this.hotComments, this.loadMoreKey);

  factory CommentList.fromJson(Map json) => _$CommentListFromJson(json);

  Map<String, dynamic> toJson() => _$CommentListToJson(this);
}

@JsonSerializable()
class Comment {
  /// COMMENT
  final String type;
  final String id;

  /// ORIGINAL_POST
  final String targetType;

  final String targetId;
  final String threadId;
  final String createdAt;
  final int level;
  final String content;
  final int likeCount;
  final int replyCount;

  /// NORMAL
  final String status;

  final UserInfo user;

  @JsonKey(defaultValue: [])
  final List<Picture> pictures;

  final bool liked;

  @JsonKey(defaultValue: [])
  final List<Comment> hotReplies;

  /// 回复的评论
  final Comment replyToComment;

  Comment(
      this.type,
      this.id,
      this.targetType,
      this.targetId,
      this.threadId,
      this.createdAt,
      this.level,
      this.content,
      this.likeCount,
      this.replyCount,
      this.status,
      this.user,
      this.pictures,
      this.liked,
      this.hotReplies,
      this.replyToComment);

  factory Comment.fromJson(Map json) => _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
