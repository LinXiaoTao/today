import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserInfo {
  final String username;

  /// 昵称
  final String screenName;

  final String createdAt;

  @JsonKey(defaultValue: false)
  final bool isVerified;

  @JsonKey(defaultValue: '')
  final String verifyMessage;

  @JsonKey(defaultValue: '')
  final String profileImageUrl;

  final UserAvatar avatarImage;

  @JsonKey(defaultValue: [])
  final List<TrailingIcons> trailingIcons;

  final StatsCount statsCount;

  final String id;

  final Preferences preferences;

  final bool isBetaUser;

  final bool usernameSet;

  final bool isLoginUser;

  final String profileVisitDescription;

  /// 简介
  final String briefIntro;

  /// 简介
  final String bio;

  /// post-nine-pictures
  final List<String> enabledFeatures;

  /// 性别：MALE
  final String gender;

  final String city;

  final String country;

  final String province;

  final String ref;

  UserInfo(
      this.username,
      this.screenName,
      this.createdAt,
      this.isVerified,
      this.verifyMessage,
      this.profileImageUrl,
      this.avatarImage,
      this.trailingIcons,
      this.statsCount,
      this.id,
      this.preferences,
      this.isBetaUser,
      this.usernameSet,
      this.isLoginUser,
      this.profileVisitDescription,
      this.briefIntro,
      this.bio,
      this.enabledFeatures,
      this.gender,
      this.city,
      this.country,
      this.province,
      this.ref);

  factory UserInfo.fromJson(Map json) => _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

@JsonSerializable()
class UserAvatar {
  final String thumbnailUrl;
  final String smallPicUrl;
  final String picUrl;

  /// jpeg
  final String format;
  final String badgeUrl;

  UserAvatar(
      {this.thumbnailUrl,
      this.smallPicUrl,
      this.picUrl,
      this.format,
      this.badgeUrl});

  factory UserAvatar.fromJson(Map json) => _$UserAvatarFromJson(json);

  Map<String, dynamic> toJson() => _$UserAvatarToJson(this);
}

@JsonSerializable()
class StatsCount {
  final int topicSubscribed;
  final int topicCreated;
  final int followedCount;
  final int followingCount;
  final int highlightedPersonalUpdates;
  final int liked;

  StatsCount(
      {this.topicSubscribed,
      this.topicCreated,
      this.followedCount,
      this.followingCount,
      this.highlightedPersonalUpdates,
      this.liked});

  factory StatsCount.fromJson(Map json) => _$StatsCountFromJson(json);

  Map<String, dynamic> toJson() => _$StatsCountToJson(this);
}

@JsonSerializable()
class Preferences {
  final bool autoPlayVideo;
  final bool topicTagGuideOn;
  final bool dailyNotificationOn;
  final bool followedNotificationOn;
  final bool subscribeWeatherForecast;
  final bool privateTopicSubscribe;
  final bool undiscoverableByPhoneNumber;
  final bool saveDataUsageMode;

  /// ASK
  final String topicPushSettings;
  final bool debugLogOn;

  /// prod
  final String env;

  final bool syncCommentToPersonalActivity;
  final bool repostWithComment;
  final bool enablePrivateChat;
  final bool blockStrangerPoke;
  final bool enablePictureWatermark;
  final bool enableOperationPush;
  final bool enableChatSound;
  final bool openMessageTabOnLaunch;

  /// TAB_RECOMMEND
  final String tabOnLaunch;
  final bool hideSubscribeTab;

  Preferences(
      {this.autoPlayVideo,
      this.topicTagGuideOn,
      this.dailyNotificationOn,
      this.followedNotificationOn,
      this.subscribeWeatherForecast,
      this.privateTopicSubscribe,
      this.undiscoverableByPhoneNumber,
      this.saveDataUsageMode,
      this.topicPushSettings,
      this.debugLogOn,
      this.env,
      this.syncCommentToPersonalActivity,
      this.repostWithComment,
      this.enablePrivateChat,
      this.blockStrangerPoke,
      this.enablePictureWatermark,
      this.enableOperationPush,
      this.enableChatSound,
      this.openMessageTabOnLaunch,
      this.tabOnLaunch,
      this.hideSubscribeTab});

  factory Preferences.fromJson(Map json) => _$PreferencesFromJson(json);

  Map<String, dynamic> toJson() => _$PreferencesToJson(this);
}

@JsonSerializable()
class Background {
  final String picUrl;

  Background(this.picUrl);

  factory Background.fromJson(Map json) => _$BackgroundFromJson(json);

  Map<String, dynamic> toJson() => _$BackgroundToJson(this);
}

@JsonSerializable()
class TrailingIcons {
  final String url;
  final String picUrl;

  TrailingIcons(this.url, this.picUrl);

  factory TrailingIcons.fromJson(Map json) => _$TrailingIconsFromJson(json);

  Map<String, dynamic> toJson() => _$TrailingIconsToJson(this);
}
