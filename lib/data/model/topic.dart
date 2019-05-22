import 'package:json_annotation/json_annotation.dart';
import 'package:today/data/model/picture.dart';
import 'package:today/data/model/user.dart';

part 'topic.g.dart';

/// 主题
@JsonSerializable()
class Topic {
  final String id;

  ///TOPIC
  final String type;

  final String content;

  /// 698414
  final int subscribersCount;

  /// 69 万
  final String approximateSubscribersCount;

  /// 腾讯自研反恐军事竞赛体验手游，原刺激战场玩家俱乐部。
  final String briefIntro;

  final Picture squarePicture;

  final bool enablePictureComments;

  final bool enablePictureWatermark;

  final bool isValid;

  /// OFFICIAL
  final String topicType;

  /// ONLINE
  final String operateStatus;

  final bool isCommentForbidden;

  /// 2019-05-11T09:16:36.326Z
  final String lastMessagePostTime;

  ///2019-05-11T09:16:36.326Z
  final String squarePostUpdateTime;

  /// 和平精英
  final String subscribersName;

  /// 在此集结
  final String subscribersAction;

  /// 名和平精英在此集结
  final String subscribersTextSuffix;

  /// 69万名和平精英在此集结
  final String subscribersDescription;

  /// 腾讯自研反恐军事竞赛体验手游，原刺激战场玩家俱乐部。
  final String intro;

  /// PERSONAL_UPDATE_RECOMMENDATION
  final String ref;

  final InvolvedUsers involvedUsers;

  Topic(
      this.id,
      this.type,
      this.content,
      this.subscribersCount,
      this.approximateSubscribersCount,
      this.briefIntro,
      this.squarePicture,
      this.enablePictureComments,
      this.enablePictureWatermark,
      this.isValid,
      this.topicType,
      this.operateStatus,
      this.isCommentForbidden,
      this.lastMessagePostTime,
      this.squarePostUpdateTime,
      this.subscribersName,
      this.subscribersAction,
      this.subscribersTextSuffix,
      this.subscribersDescription,
      this.intro,
      this.ref,
      this.involvedUsers);

  factory Topic.fromJson(Map json) => _$TopicFromJson(json);

  Map<String, dynamic> toJson() => _$TopicToJson(this);
}

@JsonSerializable()
class InvolvedUsers {
  final List<UserInfo> users;

  InvolvedUsers(this.users);

  factory InvolvedUsers.fromJson(Map json) => _$InvolvedUsersFromJson(json);

  Map<String, dynamic> toJson() => _$InvolvedUsersToJson(this);
}
