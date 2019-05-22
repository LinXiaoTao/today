import 'package:json_annotation/json_annotation.dart';

part 'shortcuts.g.dart';

@JsonSerializable()
class ShortcutsData {
  final String title;
  final int recommendCount;
  final List<Shortcut> shortcuts;

  ShortcutsData(this.title, this.recommendCount, this.shortcuts);

  factory ShortcutsData.fromJson(Map json) => _$ShortcutsDataFromJson(json);

  Map<String, dynamic> toJson() => _$ShortcutsDataToJson(this);
}

@JsonSerializable()
class Shortcut {
  final String id;

  ///SPECIAL, SUBSCRIBED
  final String type;

  /// SPECIAL, TOPIC
  final String contentType;

  final String content;

  final String url;

  final String picUrl;

  /// DOTTED, YELLOW,
  @JsonKey(defaultValue: '')
  final String style;

  Shortcut(this.id, this.type, this.contentType, this.content, this.url,
      this.picUrl, this.style);

  factory Shortcut.fromJson(Map json) => _$ShortcutFromJson(json);

  Map<String, dynamic> toJson() => _$ShortcutToJson(this);
}
