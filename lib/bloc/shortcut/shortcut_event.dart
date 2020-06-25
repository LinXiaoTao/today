import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ShortcutEvent extends Equatable {}

class FetchShortcutEvent extends ShortcutEvent {
  @override
  String toString() {
    return 'FetchShortcutEvent{}';
  }

  @override
  List<Object> get props => [];
}
