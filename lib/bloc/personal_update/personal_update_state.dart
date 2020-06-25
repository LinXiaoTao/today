import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:today/data/model/models.dart';

@immutable
abstract class PersonalUpdateState extends Equatable {}

class InitialPersonalActivityState extends PersonalUpdateState {
  @override
  List<Object> get props => [];
}

class LoadedPersonalActivityState extends PersonalUpdateState {
  final List<Message> items;

  LoadedPersonalActivityState(this.items) : super();

  @override
  String toString() {
    return 'LoadedPersonalActivityState{items: $items}';
  }

  @override
  List<Object> get props => [items];
}
