import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MessageRelatedEvent extends Equatable {
  MessageRelatedEvent([List props = const []]) : super(props);
}

class FetchMessageRelatedListEvent extends MessageRelatedEvent {
  final String id;
  final String pageName;

  FetchMessageRelatedListEvent(this.id, {this.pageName = ''})
      : super([id, pageName]);

  @override
  String toString() {
    return 'FetchMessageRelatedListEvent{id: $id, pageName: $pageName}';
  }
}
