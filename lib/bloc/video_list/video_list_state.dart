import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:today/data/model/models.dart';

@immutable
abstract class VideoListState extends Equatable {}

class InitialVideoListState extends VideoListState {
  @override
  List<Object> get props => [];
}

class LoadedVideoListState extends VideoListState {
  final List<Message> items;

  LoadedVideoListState(this.items) : super();

  @override
  String toString() {
    return 'LoadedVideoListState{items: $items}';
  }

  @override
  List<Object> get props => [items];
}
