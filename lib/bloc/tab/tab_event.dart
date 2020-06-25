import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TabEvent extends Equatable {}

class SwitchTabEvent extends TabEvent {
  final int switchIndex;

  SwitchTabEvent({this.switchIndex = 0}) : super();

  @override
  String toString() {
    return 'SwitchTabEvent{switchIndex: $switchIndex}';
  }

  @override
  List<Object> get props => [switchIndex];
}
