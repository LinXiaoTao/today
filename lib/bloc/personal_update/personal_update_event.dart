import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PersonalUpdateEvent extends Equatable {}

class FetchPersonalUpdateEvent extends PersonalUpdateEvent {
  final int limit;
  final String username;
  final bool loadMore;

  FetchPersonalUpdateEvent(this.username,
      {this.loadMore = false, this.limit = 25})
      : super();

  @override
  String toString() {
    return 'FetchPersonalUpdateEvent{limit: $limit, username: $username, loadMore: $loadMore}';
  }

  @override
  List<Object> get props => [limit, username, loadMore];
}
