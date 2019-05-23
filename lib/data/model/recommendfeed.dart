import 'package:json_annotation/json_annotation.dart';
import 'package:today/data/model/picture.dart';
import 'package:today/data/model/poi.dart';
import 'package:today/data/model/topic.dart';
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

  @JsonKey(defaultValue: '')
  final String content;

  @JsonKey(defaultValue: [])
  final List<UrlsInText> urlsInText;

  /// NORMAL
  final String status;

  final bool isCommentForbidden;

  final int likeCount;

  final int commentCount;

  final int repostCount;

  final int shareCount;

  final Topic topic;

  final Poi poi;

  @JsonKey(defaultValue: [])
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
      this.urlsInText,
      this.status,
      this.isCommentForbidden,
      this.likeCount,
      this.commentCount,
      this.repostCount,
      this.shareCount,
      this.topic,
      this.poi,
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

@JsonSerializable()
class UrlsInText {
  final String title;
  final String originalUrl;
  final String url;

  /// hashtag
  final String type;

  UrlsInText(this.title, this.originalUrl, this.url, this.type);

  factory UrlsInText.fromJson(Map json) => _$UrlsInTextFromJson(json);

  Map<String, dynamic> toJson() => _$UrlsInTextToJson(this);
}
