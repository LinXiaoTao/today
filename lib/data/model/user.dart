import 'package:json_annotation/json_annotation.dart';
import 'models.dart';

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

  final Picture backgroundImage;

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
  @JsonKey(defaultValue: '')
  final String gender;

  /// 星座
  @JsonKey(defaultValue: '')
  final String zodiac;

  /// 行业
  @JsonKey(defaultValue: '')
  final String industry;

  @JsonKey(defaultValue: '')
  final String city;

  @JsonKey(defaultValue: '')
  final String country;

  @JsonKey(defaultValue: '')
  final String province;

  final String ref;

  @JsonKey(defaultValue: [])
  final List<Medals> medals;

  @JsonKey(defaultValue: [])
  final List<TrailingIcons> profileTags;

  String get genderText {
    if (gender.isEmpty) return '';
    return this.gender == 'MALE' ? '他' : '她';
  }

  String get genderType {
    if (gender.isEmpty) return '';
    return this.gender == 'MALE' ? '男' : '女';
  }

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
    this.backgroundImage,
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
    this.zodiac,
    this.industry,
    this.city,
    this.country,
    this.province,
    this.ref,
    this.profileTags,
    this.medals,
  );

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
  @JsonKey(defaultValue: 0)
  final int topicSubscribed;
  @JsonKey(defaultValue: 0)
  final int topicCreated;
  @JsonKey(defaultValue: 0)
  final int followedCount;
  @JsonKey(defaultValue: 0)
  final int followingCount;
  @JsonKey(defaultValue: 0)
  final int highlightedPersonalUpdates;
  @JsonKey(defaultValue: 0)
  final int liked;

  String get formatLiked {
    if (liked < 1000) return liked.toString();
    return '${(liked / 1000.0).toStringAsFixed(1)}k';
  }

  String get formatHighlightedPersonalUpdates {
    if (highlightedPersonalUpdates < 1000)
      return highlightedPersonalUpdates.toString();
    return '${(highlightedPersonalUpdates / 1000.0).toStringAsFixed(1)}k';
  }

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
  @JsonKey(defaultValue: '')
  final String url;
  @JsonKey(defaultValue: '')
  final String picUrl;
  @JsonKey(defaultValue: '')
  final String text;

  /// NORMAL
  final String type;

  TrailingIcons(this.url, this.picUrl, this.text, this.type);

  factory TrailingIcons.fromJson(Map json) => _$TrailingIconsFromJson(json);

  Map<String, dynamic> toJson() => _$TrailingIconsToJson(this);
}

@JsonSerializable()
class Medals {
  @JsonKey(defaultValue: '')
  final String picUrl;
  @JsonKey(defaultValue: '')
  final String url;
  @JsonKey(defaultValue: '')
  final String name;
  @JsonKey(defaultValue: '')
  final String gotMedalAt;

  Medals(this.picUrl, this.url, this.name, this.gotMedalAt);

  factory Medals.fromJson(Map json) => _$MedalsFromJson(json);

  Map<String, dynamic> toJson() => _$MedalsToJson(this);
}
