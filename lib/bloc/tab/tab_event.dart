import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TabEvent extends Equatable {
  TabEvent([List props = const []]) : super(props);
}

class SwitchTabEvent extends TabEvent {
  final int switchIndex;

  SwitchTabEvent({this.switchIndex = 0}) : super([switchIndex]);

  @override
  String toString() {
    return 'SwitchTabEvent{switchIndex: $switchIndex}';
  }
}
