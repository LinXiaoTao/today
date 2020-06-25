import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TabState extends Equatable {}

class InitialTabState extends TabState {
  @override
  List<Object> get props => [];
}

class SwitchTabState extends TabState {
  final int switchIndex;

  SwitchTabState({this.switchIndex}) : super();

  @override
  String toString() {
    return 'SwitchTabState{switchIndex: $switchIndex}';
  }

  @override
  List<Object> get props => [switchIndex];
}
