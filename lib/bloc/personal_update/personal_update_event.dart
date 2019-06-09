import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PersonalUpdateEvent extends Equatable {
  PersonalUpdateEvent([List props = const []]) : super(props);
}

class FetchPersonalUpdateEvent extends PersonalUpdateEvent {
  final int limit;
  final String username;
  final bool loadMore;

  FetchPersonalUpdateEvent(this.username,
      {this.loadMore = false, this.limit = 25})
      : super([limit, username, loadMore]);

  @override
  String toString() {
    return 'FetchPersonalUpdateEvent{limit: $limit, username: $username, loadMore: $loadMore}';
  }
}
