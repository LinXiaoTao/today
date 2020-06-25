import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PersonalDetailEvent extends Equatable {
}

class FetchPersonalDataEvent extends PersonalDetailEvent {
  final String username;

  FetchPersonalDataEvent(this.username) : super();

  @override
  String toString() {
    return 'FetchPersonalDataEvent{username: $username}';
  }

  @override
  List<Object> get props => [username];
}
