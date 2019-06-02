import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MediaState extends Equatable {
  MediaState([List props = const []]) : super(props);
}

class InitialMediaState extends MediaState {}

class LoadedMediaState extends MediaState {
  final String url;

  LoadedMediaState(this.url) : super([url]);

  @override
  String toString() {
    return 'LoadedMediaState{url: $url}';
  }
}
