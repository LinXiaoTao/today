import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MediaState extends Equatable {}

class InitialMediaState extends MediaState {
  @override
  List<Object> get props => [];
}

class LoadedMediaState extends MediaState {
  final String url;

  LoadedMediaState(this.url) : super();

  @override
  String toString() {
    return 'LoadedMediaState{url: $url}';
  }

  @override
  List<Object> get props => [url];
}
