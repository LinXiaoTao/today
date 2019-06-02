import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class TabBloc extends Bloc<TabEvent, TabState> {
  int curTabIndex = 0;

  @override
  TabState get initialState => InitialTabState();

  @override
  Stream<TabState> mapEventToState(
    TabEvent event,
  ) async* {
    if (event is SwitchTabEvent) {
      yield* _mapSwitchTabEventToState(event);
    }
  }

  Stream<SwitchTabState> _mapSwitchTabEventToState(
      SwitchTabEvent event) async* {
    curTabIndex = event.switchIndex;
    yield SwitchTabState(switchIndex: event.switchIndex);
  }
}
