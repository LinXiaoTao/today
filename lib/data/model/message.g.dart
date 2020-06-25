// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map json) {
  return Message(
    json['id'] as String,
    json['type'] as String ?? '',
    json['content'] as String ?? '',
    json['title'] as String ?? '',
    (json['urlsInText'] as List)
            ?.map((e) => e == null ? null : UrlsInText.fromJson(e as Map))
            ?.toList() ??
        [],
    json['status'] as String ?? '',
    json['isCommentForbidden'] as bool,
    json['likeCount'] as int ?? 0,
    json['commentCount'] as int ?? 0,
    json['repostCount'] as int ?? 0,
    json['shareCount'] as int,
    json['topic'] == null ? null : Topic.fromJson(json['topic'] as Map),
    json['poi'] == null ? null : Poi.fromJson(json['poi'] as Map),
    json['linkInfo'] == null
        ? null
        : LinkInfo.fromJson(json['linkInfo'] as Map),
    (json['pictures'] as List)
            ?.map((e) => e == null ? null : Picture.fromJson(e as Map))
            ?.toList() ??
        [],
    json['user'] == null ? null : UserInfo.fromJson(json['user'] as Map),
    json['createdAt'] as String,
    json['messageId'] as String,
    json['video'] == null ? null : Video.fromJson(json['video'] as Map),
    json['subtitle'] as String,
    (json['attachedComments'] as List)
            ?.map((e) => e == null ? null : Comment.fromJson(e as Map))
            ?.toList() ??
        [],
    json['target'] == null ? null : Message.fromJson(json['target'] as Map),
    json['viewType'] as String ?? '',
    json['questionId'] as String ?? 'questionId',
    json['question'] == null ? null : Message.fromJson(json['question'] as Map),
    json['answerCount'] as int ?? 0,
    json['richtextContent'] == null
        ? null
        : RichTextContent.fromJson(json['richtextContent'] as Map),
    json['upVoteCount'] as int ?? 0,
    (json['items'] as List)
        ?.map((e) => e == null ? null : RecommendHeadItem.fromJson(e as Map))
        ?.toList(),
    json['dislikeMenu'] == null
        ? null
        : DislikeMenu.fromJson(json['dislikeMenu'] as Map),
    json['action'] as String ?? '',
    json['text'] as String ?? '',
    json['picture'] == null ? null : Picture.fromJson(json['picture'] as Map),
    json['flags'] == null ? null : Flags.fromJson(json['flags'] as Map),
    json['button'] == null ? null : Button.fromJson(json['button'] as Map),
  );
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'content': instance.content,
      'title': instance.title,
      'urlsInText': instance.urlsInText,
      'status': instance.status,
      'isCommentForbidden': instance.isCommentForbidden,
      'likeCount': instance.likeCount,
      'commentCount': instance.commentCount,
      'repostCount': instance.repostCount,
      'shareCount': instance.shareCount,
      'topic': instance.topic,
      'poi': instance.poi,
      'linkInfo': instance.linkInfo,
      'pictures': instance.pictures,
      'user': instance.user,
      'createdAt': instance.createdAt,
      'messageId': instance.messageId,
      'video': instance.video,
      'subtitle': instance.subtitle,
      'attachedComments': instance.attachedComments,
      'target': instance.target,
      'viewType': instance.viewType,
      'questionId': instance.questionId,
      'question': instance.question,
      'richtextContent': instance.richtextContent,
      'answerCount': instance.answerCount,
      'upVoteCount': instance.upVoteCount,
      'items': instance.items,
      'dislikeMenu': instance.dislikeMenu,
      'action': instance.action,
      'text': instance.text,
      'picture': instance.picture,
      'flags': instance.flags,
      'button': instance.button,
    };

UrlsInText _$UrlsInTextFromJson(Map json) {
  return UrlsInText(
    json['title'] as String,
    json['originalUrl'] as String,
    json['url'] as String,
    json['type'] as String,
  );
}

Map<String, dynamic> _$UrlsInTextToJson(UrlsInText instance) =>
    <String, dynamic>{
      'title': instance.title,
      'originalUrl': instance.originalUrl,
      'url': instance.url,
      'type': instance.type,
    };

LinkInfo _$LinkInfoFromJson(Map json) {
  return LinkInfo(
    json['title'] as String,
    json['pictureUrl'] as String,
    json['linkUrl'] as String,
    json['source'] as String,
    json['audio'] == null ? null : Audio.fromJson(json['audio'] as Map),
    json['video'] == null ? null : Video.fromJson(json['video'] as Map),
  );
}

Map<String, dynamic> _$LinkInfoToJson(LinkInfo instance) => <String, dynamic>{
      'title': instance.title,
      'pictureUrl': instance.pictureUrl,
      'linkUrl': instance.linkUrl,
      'source': instance.source,
      'audio': instance.audio,
      'video': instance.video,
    };

Audio _$AudioFromJson(Map json) {
  return Audio(
    json['type'] as String,
    json['image'] == null ? null : Picture.fromJson(json['image'] as Map),
    json['title'] as String,
    json['author'] as String,
  );
}

Map<String, dynamic> _$AudioToJson(Audio instance) => <String, dynamic>{
      'type': instance.type,
      'image': instance.image,
      'title': instance.title,
      'author': instance.author,
    };

RichTextContent _$RichTextContentFromJson(Map json) {
  return RichTextContent(
    (json['blocks'] as List)
            ?.map((e) => e == null ? null : Block.fromJson(e as Map))
            ?.toList() ??
        [],
    json['entityMap'] as Map ?? {},
  );
}

Map<String, dynamic> _$RichTextContentToJson(RichTextContent instance) =>
    <String, dynamic>{
      'blocks': instance.blocks,
      'entityMap': instance.entityMap,
    };

Block _$BlockFromJson(Map json) {
  return Block(
    json['text'] as String ?? '',
    (json['entityRanges'] as List)
            ?.map((e) => e == null ? null : EntityRanges.fromJson(e as Map))
            ?.toList() ??
        [],
  );
}

Map<String, dynamic> _$BlockToJson(Block instance) => <String, dynamic>{
      'text': instance.text,
      'entityRanges': instance.entityRanges,
    };

EntityRanges _$EntityRangesFromJson(Map json) {
  return EntityRanges(
    json['key'] as String ?? '',
    json['length'] as int ?? 0,
    json['offset'] as int ?? 0,
  );
}

Map<String, dynamic> _$EntityRangesToJson(EntityRanges instance) =>
    <String, dynamic>{
      'key': instance.key,
      'length': instance.length,
      'offset': instance.offset,
    };
