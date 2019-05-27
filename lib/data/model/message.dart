import 'package:json_annotation/json_annotation.dart';
import 'package:today/data/model/topic.dart';
import 'package:today/data/model/poi.dart';
import 'package:today/data/model/user.dart';
import 'package:today/data/model/video.dart';
import 'package:today/data/model/comment.dart';
import 'package:today/data/model/picture.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
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

  final LinkInfo linkInfo;

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

  Message(
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
    this.linkInfo,
    this.pictures,
    this.user,
    this.createdAt,
    this.messageId,
    this.video,
    this.subtitle,
    this.topComment,
    this.attachedComments,
    this.viewType,
  );

  factory Message.fromJson(Map json) => _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
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

@JsonSerializable()
class LinkInfo {
  final String title;
  final String pictureUrl;
  final String linkUrl;
  final String source;
  final Audio audio;

  LinkInfo(this.title, this.pictureUrl, this.linkUrl, this.source, this.audio);

  factory LinkInfo.fromJson(Map json) => _$LinkInfoFromJson(json);

  Map<String, dynamic> toJson() => _$LinkInfoToJson(this);

  @override
  String toString() {
    return 'LinkInfo{title: $title, pictureUrl: $pictureUrl, linkUrl: $linkUrl, source: $source, audio: $audio}';
  }
}

@JsonSerializable()
class Audio {
  ///AUDIO
  final String type;
  final Picture image;
  final String title;
  final String author;

  Audio(this.type, this.image, this.title, this.author);

  factory Audio.fromJson(Map json) => _$AudioFromJson(json);

  Map<String, dynamic> toJson() => _$AudioToJson(this);

  @override
  String toString() {
    return 'Audio{type: $type, image: $image, title: $title, author: $author}';
  }
}
