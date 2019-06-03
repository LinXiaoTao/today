import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:today/data/model/models.dart';

@immutable
abstract class VideoListState extends Equatable {
  VideoListState([List props = const []]) : super(props);
}

class InitialVideoListState extends VideoListState {}

class LoadedVideoListState extends VideoListState {
  final List<Message> items;

  LoadedVideoListState(this.items) : super([items]);

  @override
  String toString() {
    return 'LoadedVideoListState{items: $items}';
  }
}
