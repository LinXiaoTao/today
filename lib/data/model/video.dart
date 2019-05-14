import 'package:json_annotation/json_annotation.dart';
import 'package:today/data/model/picture.dart';

part 'video.g.dart';

@JsonSerializable()
class Video {
  final String type;
  final Picture image;
  final int duration;
  final int width;
  final int height;

  Video(this.type, this.image, this.duration, this.width, this.height);

  factory Video.fromJson(Map json) => _$VideoFromJson(json);

  Map<String, dynamic> toJson() => _$VideoToJson(this);
}
