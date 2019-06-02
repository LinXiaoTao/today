import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:today/data/model/models.dart';

@immutable
abstract class ShortcutState extends Equatable {
  ShortcutState([List props = const []]) : super(props);
}

class InitialShortcutState extends ShortcutState {}

class LoadedShortcutState extends ShortcutState {
  final ShortcutsData shortcutsData;

  LoadedShortcutState(this.shortcutsData) : super([shortcutsData]);

  @override
  String toString() {
    return 'LoadedShortcutState{shortcutsData: $shortcutsData}';
  }
}
