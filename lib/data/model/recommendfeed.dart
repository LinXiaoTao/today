import 'package:json_annotation/json_annotation.dart';
import 'package:today/data/model/picture.dart';
import 'package:today/data/model/user.dart';
import 'package:today/data/model/video.dart';
import 'package:today/data/model/comment.dart';

part 'recommendfeed.g.dart';

@JsonSerializable()
class RecommendFeed {
  final List<RecommendItem> data;
  final String toastMessage;
  final LoadMoreKey loadMoreKey;

  RecommendFeed(this.data, this.toastMessage, this.loadMoreKey);

  factory RecommendFeed.fromJson(Map json) => _$RecommendFeedFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendFeedToJson(this);
}

@JsonSerializable()
class RecommendItem {
  final List<RecommendHeadItem> items;

  /// RECOMMENDED_MESSAGE || HEADLINE_RECOMMENDATION
  final String type;
  final String id;
  final RecommendBodyItem item;
  final DislikeMenu dislikeMenu;

  RecommendItem(this.items, this.type, this.id, this.item, this.dislikeMenu);

  factory RecommendItem.fromJson(Map json) => _$RecommendItemFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendItemToJson(this);
}

@JsonSerializable()
class LoadMoreKey {
  final int score;
  final bool isLastPage;
  final int page;

  LoadMoreKey(this.score, this.isLastPage, this.page);

  factory LoadMoreKey.fromJson(Map json) => _$LoadMoreKeyFromJson(json);

  Map<String, dynamic> toJson() => _$LoadMoreKeyToJson(this);
}

@JsonSerializable()
class RecommendHeadItem {
  final String id;
  final String title;

  /// jike://page.jk/topic/559e244ee4b023682f3b3100?ref=HEADLINE_HOT
  final String url;

  final String picUrl;

  ///topic
  final String type;

  RecommendHeadItem(this.id, this.title, this.url, this.picUrl, this.type);

  factory RecommendHeadItem.fromJson(Map json) =>
      _$RecommendHeadItemFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendHeadItemToJson(this);
}

@JsonSerializable()
class RecommendBodyItem {
  final String id;

  ///ORIGINAL_POST
  final String type;

  final String content;

  /// NORMAL
  final String status;

  final bool isCommentForbidden;

  final int likeCount;

  final int commentCount;

  final int repostCount;

  final int shareCount;

  final Topic topic;

  final List<Picture> pictures;

  final UserInfo user;

  final String createdAt;

  final String messageId;

  final Video video;

  final String subtitle;

  final Comment topComment;

  final List<Comment> attachedComments;

  /// MESSAGE_VIEW
  final String viewType;

  RecommendBodyItem(
      this.id,
      this.type,
      this.content,
      this.status,
      this.isCommentForbidden,
      this.likeCount,
      this.commentCount,
      this.repostCount,
      this.shareCount,
      this.topic,
      this.pictures,
      this.user,
      this.createdAt,
      this.messageId,
      this.video,
      this.subtitle,
      this.topComment,
      this.attachedComments,
      this.viewType);

  factory RecommendBodyItem.fromJson(Map json) =>
      _$RecommendBodyItemFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendBodyItemToJson(this);
}

@JsonSerializable()
class DislikeMenu {
  final String title;
  final String subtitle;
  final List<Map> reasons;

  DislikeMenu(this.title, this.subtitle, this.reasons);

  factory DislikeMenu.fromJson(Map json) => _$DislikeMenuFromJson(json);

  Map<String, dynamic> toJson() => _$DislikeMenuToJson(this);
}

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
