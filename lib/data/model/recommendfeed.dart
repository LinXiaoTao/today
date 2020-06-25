import 'package:json_annotation/json_annotation.dart';
import 'package:today/data/model/models.dart';
import 'package:equatable/equatable.dart';

part 'recommendfeed.g.dart';

@JsonSerializable()
class RecommendFeed {
  @JsonKey(defaultValue: [])
  final List<Message> data;
  @JsonKey(defaultValue: '')
  final String toastMessage;
  final LoadMoreKey loadMoreKey;

  RecommendFeed(this.data, this.toastMessage, this.loadMoreKey);

  factory RecommendFeed.fromJson(Map json) => _$RecommendFeedFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendFeedToJson(this);
}

@JsonSerializable()
class Flags {
  @JsonKey(defaultValue: false)
  final bool hideDismissIcon;
  @JsonKey(defaultValue: false)
  final bool toggleFullscreen;

  Flags(this.hideDismissIcon, this.toggleFullscreen);

  factory Flags.fromJson(Map json) => _$FlagsFromJson(json);

  Map<String, dynamic> toJson() => _$FlagsToJson(this);
}

@JsonSerializable()
class Button {
  @JsonKey(defaultValue: '')
  final String text;
  @JsonKey(defaultValue: '')
  final String linkUrl;

  Button(this.text, this.linkUrl);

  factory Button.fromJson(Map json) => _$ButtonFromJson(json);

  Map<String, dynamic> toJson() => _$ButtonToJson(this);
}

@JsonSerializable()
class LoadMoreKey {
  final int page;
  final int feedTime;
  final LoadMoreStageKey stageKey;

  LoadMoreKey(this.page, this.feedTime, this.stageKey);

  factory LoadMoreKey.fromJson(Map json) => _$LoadMoreKeyFromJson(json);

  Map<String, dynamic> toJson() => _$LoadMoreKeyToJson(this);
}

@JsonSerializable()
class LoadMoreStageKey {
  final int stage;
  final int page;

  LoadMoreStageKey(this.stage, this.page);

  factory LoadMoreStageKey.fromJson(Map json) =>
      _$LoadMoreStageKeyFromJson(json);

  Map<String, dynamic> toJson() => _$LoadMoreStageKeyToJson(this);
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
