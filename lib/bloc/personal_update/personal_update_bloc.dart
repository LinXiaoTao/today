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
      final List<Message> message = [];

      if (event.loadMore && _personalUpdate.loadMoreKey.isEmpty) {
        /// 没有更多数据
        yield LoadedPersonalActivityState(_messageList);
        return;
      }

      _personalUpdate = await ApiRequest.personalUpdates(event.username,
          limit: event.limit,
          loadMoreKey: (event.loadMore ? _personalUpdate.loadMoreKey : null));

      if (!event.loadMore) {
        _messageList.clear();
      }
      _messageList.addAll(_personalUpdate.data);
      message.addAll(_messageList);
      yield LoadedPersonalActivityState(message);
    }
  }
}
