import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:today/data/model/models.dart';

@immutable
abstract class VideoListEvent extends Equatable {}

class FetchVideoListEvent extends VideoListEvent {
  final Message message;

  FetchVideoListEvent(
    this.message,
  ) : super();

  @override
  String toString() {
    return 'FetchVideoListEvent{message: $message}';
  }

  @override
  List<Object> get props => [message];
}
