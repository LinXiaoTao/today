import 'package:json_annotation/json_annotation.dart';

part 'configs.g.dart';

@JsonSerializable()
class SearchPlaceholder {
  final String discoverTab;
  final String recommendTab;
  final String subscribeTab;
  final String homeTab;

  SearchPlaceholder(
      this.discoverTab, this.recommendTab, this.subscribeTab, this.homeTab);

  factory SearchPlaceholder.fromJson(Map json) =>
      _$SearchPlaceholderFromJson(json);

  Map<String, dynamic> toJson() => _$SearchPlaceholderToJson(this);

  @override
  String toString() {
    return 'SearchPlaceholder{discoverTab: $discoverTab, recommendTab: $recommendTab, subscribeTab: $subscribeTab, homeTab: $homeTab}';
  }
}

@JsonSerializable()
class CentralEntry {
  final String picUrl;
  final String url;
  final String title;
  final String version;

  CentralEntry(this.picUrl, this.url, this.title, this.version);

  factory CentralEntry.fromJson(Map json) => _$CentralEntryFromJson(json);

  Map<String, dynamic> toJson() => _$CentralEntryToJson(this);
}
