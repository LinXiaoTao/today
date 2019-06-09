// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map json) {
  return UserProfile(
      json['user'] == null ? null : UserInfo.fromJson(json['user'] as Map),
      json['relationMessage'] as String ?? '');
}

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'user': instance.user,
      'relationMessage': instance.relationMessage
    };
