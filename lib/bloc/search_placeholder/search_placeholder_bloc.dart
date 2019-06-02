import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:today/data/network/request.dart';

class SearchPlaceholderBloc
    extends Bloc<SearchPlaceholderEvent, SearchPlaceholderState> {
  @override
  SearchPlaceholderState get initialState => InitialSearchPlaceholderState();

  @override
  Stream<SearchPlaceholderState> mapEventToState(
    SearchPlaceholderEvent event,
  ) async* {
    if (event is FetchSearchPlaceHolderEvent) {
      yield LoadedSearchPlaceHolderState(await ApiRequest.searchPlaceholder());
    }
  }
}
