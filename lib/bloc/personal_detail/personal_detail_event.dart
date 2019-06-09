import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PersonalDetailEvent extends Equatable {
  PersonalDetailEvent([List props = const []]) : super(props);
}

class FetchPersonalDataEvent extends PersonalDetailEvent {
  final String username;

  FetchPersonalDataEvent(this.username) : super([username]);

  @override
  String toString() {
    return 'FetchPersonalDataEvent{username: $username}';
  }
}
