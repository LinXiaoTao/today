import 'package:json_annotation/json_annotation.dart';
import 'models.dart';

part 'personal_update.g.dart';

@JsonSerializable()
class PersonalUpdate {
  @JsonKey(defaultValue: [])
  final List<Message> data;
  @JsonKey(defaultValue: {})
  final Map loadMoreKey;

  PersonalUpdate(this.data, this.loadMoreKey);

  factory PersonalUpdate.fromJson(Map json) => _$PersonalUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalUpdateToJson(this);
}
