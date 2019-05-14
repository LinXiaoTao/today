import 'package:json_annotation/json_annotation.dart';

part 'picture.g.dart';

@JsonSerializable()
class Picture {
  /// 120 * 120
  final String thumbnailUrl;

  /// 300 * 300
  final String middlePicUrl;

  /// 1000 * 1000
  final String picUrl;

  final String format;

  final String averageHue;

  final int width;
  final int height;

  Picture(this.thumbnailUrl, this.middlePicUrl, this.picUrl, this.format,
      this.averageHue,
      {this.width = 0, this.height = 0});

  factory Picture.fromJson(Map json) => _$PictureFromJson(json);

  Map<String, dynamic> toJson() => _$PictureToJson(this);
}
