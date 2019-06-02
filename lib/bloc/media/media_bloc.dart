import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:today/data/network/request.dart';

class MediaBloc extends Bloc<MediaEvent, MediaState> {
  @override
  MediaState get initialState => InitialMediaState();

  @override
  Stream<MediaState> mapEventToState(
    MediaEvent event,
  ) async* {
    if (event is FetchMediaEvent) {
      Map result = await ApiRequest.mediaMeta(
          {'id': event.id, 'type': event.type, 'trigger': event.trigger});

      yield LoadedMediaState(result['url']);
    }
  }
}
