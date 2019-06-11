import 'package:json_annotation/json_annotation.dart';
import 'package:today/data/model/models.dart';
import 'package:equatable/equatable.dart';

part 'message.g.dart';

enum MessageType {
  ORIGINAL_POST,
  RE_POST,
  OFFICIAL_MESSAGE,
  ANSWER,
  QUESTION,
}

enum MessageStatus {
  NORMAL,
  DELETED,
}

@JsonSerializable()
class Message extends Equatable {
  final String id;

  final String type;

  @JsonKey(defaultValue: '')
  final String content;

  @JsonKey(defaultValue: '')
  final String title;

  @JsonKey(defaultValue: [])
  final List<UrlsInText> urlsInText;

  /// NORMAL,DELETED
  @JsonKey(defaultValue: '')
  final String status;

  final bool isCommentForbidden;

  @JsonKey(defaultValue: 0)
  final int likeCount;

  @JsonKey(defaultValue: 0)
  final int commentCount;

  @JsonKey(defaultValue: 0)
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

  /// type = 'REPOST'
  final Message target;

  /// MESSAGE_VIEW
  final String viewType;

  @JsonKey(defaultValue: 'questionId')
  final String questionId;

  final Message question;

  final RichTextContent richtextContent;

  @JsonKey(defaultValue: 0)
  final int answerCount;

  @JsonKey(defaultValue: 0)
  final int upVoteCount;

  Message(
    this.id,
    this.type,
    this.content,
    this.title,
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
    this.target,
    this.viewType,
    this.questionId,
    this.question,
    this.answerCount,
    this.richtextContent,
    this.upVoteCount,
  ) : super([id]);

  factory Message.fromJson(Map json) => _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);

  MessageType get messageType {
    if (type == 'ORIGINAL_POST') {
      return MessageType.ORIGINAL_POST;
    } else if (type == 'REPOST') {
      return MessageType.RE_POST;
    } else if (type == 'OFFICIAL_MESSAGE') {
      return MessageType.OFFICIAL_MESSAGE;
    } else if (type == 'ANSWER') {
      return MessageType.ANSWER;
    } else if (type == 'QUESTION') {
      return MessageType.QUESTION;
    }
    return MessageType.ORIGINAL_POST;
  }

  MessageStatus get messageStatus {
    if (status == 'DELETED') {
      return MessageStatus.DELETED;
    }
    return MessageStatus.NORMAL;
  }
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

  @override
  String toString() {
    return 'UrlsInText{originalUrl: $originalUrl}';
  }
}

@JsonSerializable()
class LinkInfo {
  final String title;
  final String pictureUrl;
  final String linkUrl;
  final String source;
  final Audio audio;
  final Video video;

  LinkInfo(this.title, this.pictureUrl, this.linkUrl, this.source, this.audio,
      this.video);

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

@JsonSerializable()
class RichTextContent {
  @JsonKey(defaultValue: [])
  final List<Block> blocks;

  RichTextContent(this.blocks);

  factory RichTextContent.fromJson(Map json) => _$RichTextContentFromJson(json);

  Map<String, dynamic> toJson() => _$RichTextContentToJson(this);
}

@JsonSerializable()
class Block {
  final String text;

  Block(this.text);

  factory Block.fromJson(Map json) => _$BlockFromJson(json);

  Map<String, dynamic> toJson() => _$BlockToJson(this);
}
