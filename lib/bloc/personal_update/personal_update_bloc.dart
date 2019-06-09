import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:today/data/network/request.dart';

class PersonalUpdateBloc
    extends Bloc<PersonalUpdateEvent, PersonalUpdateState> {
  final List<Message> _messageList = [];
  PersonalUpdate _personalUpdate;

  @override
  PersonalUpdateState get initialState => InitialPersonalActivityState();

  @override
  Stream<PersonalUpdateState> mapEventToState(
    PersonalUpdateEvent event,
  ) async* {
    if (event is FetchPersonalUpdateEvent) {
      _personalUpdate =
          await ApiRequest.personalUpdates(event.username, limit: event.limit);
      _messageList.addAll(_personalUpdate.data);
      yield LoadedPersonalActivityState(_messageList);
    }
  }
}
