import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:today/data/network/request.dart';

class VideoListBloc extends Bloc<VideoListEvent, VideoListState> {
  @override
  VideoListState get initialState => InitialVideoListState();

  @override
  Stream<VideoListState> mapEventToState(
    VideoListEvent event,
  ) async* {
    if (event is FetchVideoListEvent) {
      List<Message> items = [];
      items.add(event.message);
      List<Message> relatedVideoList = await ApiRequest.relatedVideo(
          event.message.id,
          type: event.message.type);
      items.addAll(relatedVideoList);
      yield LoadedVideoListState(items);
    }
  }
}
