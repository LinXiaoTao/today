// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Poi _$PoiFromJson(Map json) {
  return Poi(
      (json['location'] as List)?.map((e) => (e as num)?.toDouble())?.toList(),
      json['pname'] as String,
      json['poiId'] as String,
      json['cityname'] as String,
      json['name'] as String,
      json['countryname'] as String,
      json['formattedAddress'] as String);
}

Map<String, dynamic> _$PoiToJson(Poi instance) => <String, dynamic>{
      'location': instance.location,
      'pname': instance.pname,
      'poiId': instance.poiId,
      'cityname': instance.cityname,
      'name': instance.name,
      'countryname': instance.countryname,
      'formattedAddress': instance.formattedAddress
    };
