import 'package:json_annotation/json_annotation.dart';
import 'package:today/data/model/message.dart';

part 'recommendfeed.g.dart';

@JsonSerializable()
class RecommendFeed {
  @JsonKey(defaultValue: [])
  final List<RecommendItem> data;
  @JsonKey(defaultValue: '')
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
  final Message item;
  final DislikeMenu dislikeMenu;

  ///BACK_TO_TOP
  @JsonKey(defaultValue: '')
  final String action;
  @JsonKey(defaultValue: '')
  final String text;

  RecommendItem(this.items, this.type, this.id, this.item, this.dislikeMenu,
      this.action, this.text);

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
class DislikeMenu {
  final String title;
  final String subtitle;
  final List<Map> reasons;

  DislikeMenu(this.title, this.subtitle, this.reasons);

  factory DislikeMenu.fromJson(Map json) => _$DislikeMenuFromJson(json);

  Map<String, dynamic> toJson() => _$DislikeMenuToJson(this);
}
