import 'package:json_annotation/json_annotation.dart';
import 'models.dart';

part 'user_profile.g.dart';

@JsonSerializable()
class UserProfile {
  final UserInfo user;
  @JsonKey(defaultValue: '')
  final String relationMessage;

  UserProfile(this.user, this.relationMessage);

  factory UserProfile.fromJson(Map json) => _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}
