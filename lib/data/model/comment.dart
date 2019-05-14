import 'package:json_annotation/json_annotation.dart';
import 'package:today/data/model/user.dart';
import 'package:today/data/model/picture.dart';

part 'comment.g.dart';

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

  final List<Picture> pictures;

  final bool liked;

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
      this.liked);

  factory Comment.fromJson(Map json) => _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
