import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:today/data/model/models.dart';

@immutable
abstract class PersonalUpdateState extends Equatable {
  PersonalUpdateState([List props = const []]) : super(props);
}

class InitialPersonalActivityState extends PersonalUpdateState {}

class LoadedPersonalActivityState extends PersonalUpdateState {
  final List<Message> items;

  LoadedPersonalActivityState(this.items) : super([items]);

  @override
  String toString() {
    return 'LoadedPersonalActivityState{items: $items}';
  }
}
