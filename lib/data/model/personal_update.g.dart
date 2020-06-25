// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonalUpdate _$PersonalUpdateFromJson(Map json) {
  return PersonalUpdate(
    (json['data'] as List)
            ?.map((e) => e == null ? null : Message.fromJson(e as Map))
            ?.toList() ??
        [],
    json['loadMoreKey'] as Map ?? {},
  );
}

Map<String, dynamic> _$PersonalUpdateToJson(PersonalUpdate instance) =>
    <String, dynamic>{
      'data': instance.data,
      'loadMoreKey': instance.loadMoreKey,
    };
