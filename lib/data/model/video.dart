import 'package:json_annotation/json_annotation.dart';
import 'package:today/data/model/picture.dart';

part 'video.g.dart';

@JsonSerializable()
class Video {
  @JsonKey(defaultValue: '')
  final String type;
  final Picture image;
  @JsonKey(defaultValue: 0)
  final int duration;
  @JsonKey(defaultValue: 0)
  final double width;
  @JsonKey(defaultValue: 0)
  final double height;

  Video(this.type, this.image, this.duration, this.width, this.height);

  factory Video.fromJson(Map json) => _$VideoFromJson(json);

  Map<String, dynamic> toJson() => _$VideoToJson(this);
}
