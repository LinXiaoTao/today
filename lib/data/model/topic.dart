import 'package:json_annotation/json_annotation.dart';
import 'package:today/data/model/picture.dart';
import 'package:today/data/model/user.dart';

part 'topic.g.dart';

@JsonSerializable()
class TopicList {
  @JsonKey(defaultValue: -1)
  final int loadMoreKey;
  @JsonKey(defaultValue: [])
  final List<Topic> data;

  TopicList(this.loadMoreKey, this.data);

  factory TopicList.fromJson(Map json) => _$TopicListFromJson(json);

  Map<String, dynamic> toJson() => _$TopicListToJson(this);
}

/// 主题
@JsonSerializable()
class Topic {
  @JsonKey(defaultValue: '')
  final String id;

  ///TOPIC
  @JsonKey(defaultValue: '')
  final String type;

  /// 《生活大爆炸》最新资讯
  @JsonKey(defaultValue: '')
  final String messagePrefix;

  @JsonKey(defaultValue: 0)
  final int topicId;

  /// 《生活大爆炸》追剧小组
  @JsonKey(defaultValue: '')
  final String content;

  @JsonKey(defaultValue: '')
  final String timeForRank;

  @JsonKey(defaultValue: '')
  final String lastMessagePostTime;

  @JsonKey(defaultValue: false)
  final bool isAnonymous;

  @JsonKey(defaultValue: false)
  final bool isDreamTopic;

  @JsonKey(defaultValue: '')
  final String createdAt;

  @JsonKey(defaultValue: '')
  final String updatedAt;

  /// 698414
  @JsonKey(defaultValue: 0)
  final int subscribersCount;

  /// 2 是已关注
  @JsonKey(defaultValue: 0)
  int subscribedStatusRawValue;

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
  @JsonKey(defaultValue: '')
  final String ref;

  final InvolvedUsers involvedUsers;

  String get subscribersCountText {
    if (subscribersCount < 100 * 10000) {
      return subscribersCount.toString();
    }

    return '${(subscribersCount / 10000).toStringAsFixed(0)}万+';
  }

  @JsonKey(ignore: true)
  bool get subscribersState {
    return subscribedStatusRawValue == 2;
  }

  set subscribersState(bool state) {
    subscribedStatusRawValue = state ? 2 : 0;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Topic &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          subscribedStatusRawValue == other.subscribedStatusRawValue;

  @override
  int get hashCode => id.hashCode ^ subscribedStatusRawValue.hashCode;

  Topic(
      this.id,
      this.type,
      this.messagePrefix,
      this.topicId,
      this.content,
      this.timeForRank,
      this.lastMessagePostTime,
      this.isAnonymous,
      this.isDreamTopic,
      this.createdAt,
      this.updatedAt,
      this.subscribersCount,
      this.subscribedStatusRawValue,
      this.approximateSubscribersCount,
      this.briefIntro,
      this.squarePicture,
      this.enablePictureComments,
      this.enablePictureWatermark,
      this.isValid,
      this.topicType,
      this.operateStatus,
      this.isCommentForbidden,
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

@JsonSerializable()
class TopicTab {
  @JsonKey(defaultValue: '')
  final String name;
  @JsonKey(defaultValue: '')
  final String alias;

  TopicTab(this.name, this.alias);

  factory TopicTab.fromJson(Map json) => _$TopicTabFromJson(json);

  Map<String, dynamic> toJson() => _$TopicTabToJson(this);
}
