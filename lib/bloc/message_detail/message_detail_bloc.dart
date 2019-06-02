import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:today/data/network/request.dart';

class MessageDetailBloc extends Bloc<MessageDetailEvent, MessageDetailState> {
  @override
  MessageDetailState get initialState => InitialMessageDetailState();

  @override
  Stream<MessageDetailState> mapEventToState(
    MessageDetailEvent event,
  ) async* {
    if (event is FetchMessageDetailEvent) {
      yield LoadedMessageDetailState(
          await ApiRequest.originalPostsGet(event.id, userRef: event.ref));
    }
  }
}
