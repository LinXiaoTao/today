import 'package:json_annotation/json_annotation.dart';

part 'poi.g.dart';

@JsonSerializable()
class Poi {
  final List<double> location;
  final String pname;
  final String poiId;
  final String cityname;
  final String name;
  final String countryname;
  final String formattedAddress;

  Poi(this.location, this.pname, this.poiId, this.cityname, this.name,
      this.countryname, this.formattedAddress);

  factory Poi.fromJson(Map json) => _$PoiFromJson(json);

  Map<String, dynamic> toJson() => _$PoiToJson(this);
}
