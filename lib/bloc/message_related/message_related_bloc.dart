import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:today/data/network/request.dart';

class MessageRelatedBloc
    extends Bloc<MessageRelatedEvent, MessageRelatedState> {
  @override
  MessageRelatedState get initialState => InitialMessageRelatedState();

  @override
  Stream<MessageRelatedState> mapEventToState(
    MessageRelatedEvent event,
  ) async* {
    if (event is FetchMessageRelatedListEvent) {
      if (event.type == MessageType.ORIGINAL_POST) {
        yield LoadedMessageRelatedListState(
            messageList: await ApiRequest.listRelated(event.id,
                pageName: event.pageName));
      } else {
        yield LoadedMessageRelatedListState(
            messageList: await ApiRequest.officialListRelated(event.id,
                pageName: event.pageName));
      }
    }
  }
}
