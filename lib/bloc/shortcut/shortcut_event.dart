import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ShortcutEvent extends Equatable {
  ShortcutEvent([List props = const []]) : super(props);
}

class FetchShortcutEvent extends ShortcutEvent {
  @override
  String toString() {
    return 'FetchShortcutEvent{}';
  }
}
