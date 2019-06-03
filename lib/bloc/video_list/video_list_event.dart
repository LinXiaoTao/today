import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:today/data/model/models.dart';

@immutable
abstract class VideoListEvent extends Equatable {
  VideoListEvent([List props = const []]) : super(props);
}

class FetchVideoListEvent extends VideoListEvent {
  final Message message;

  FetchVideoListEvent(
    this.message,
  ) : super([message]);

  @override
  String toString() {
    return 'FetchVideoListEvent{message: $message}';
  }
}
