import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:today/data/network/request.dart';

class ShortcutBloc extends Bloc<ShortcutEvent, ShortcutState> {
  @override
  ShortcutState get initialState => InitialShortcutState();

  @override
  Stream<ShortcutState> mapEventToState(
    ShortcutEvent event,
  ) async* {
    if (event is FetchShortcutEvent) {
      yield LoadedShortcutState(await ApiRequest.shortcutsList());
    }
  }
}
