import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:today/data/model/models.dart';

@immutable
abstract class ShortcutState extends Equatable {}

class InitialShortcutState extends ShortcutState {
  @override
  List<Object> get props => [];
}

class LoadedShortcutState extends ShortcutState {
  final ShortcutsData shortcutsData;

  LoadedShortcutState(this.shortcutsData) : super();

  @override
  String toString() {
    return 'LoadedShortcutState{shortcutsData: $shortcutsData}';
  }

  @override
  List<Object> get props => [shortcutsData];
}
