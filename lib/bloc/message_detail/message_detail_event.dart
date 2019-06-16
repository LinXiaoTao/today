import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:today/data/model/models.dart';

@immutable
abstract class MessageDetailEvent extends Equatable {
  MessageDetailEvent([List props = const []]) : super(props);
}

class FetchMessageDetailEvent extends MessageDetailEvent {
  final String id;
  final String userRef;
  final MessageType type;
  final String topicRef;

  FetchMessageDetailEvent(this.id,
      {this.userRef = '',
      this.topicRef = '',
      this.type = MessageType.ORIGINAL_POST})
      : super([id, userRef, topicRef]);

  @override
  String toString() {
    return 'FetchMessageDetailEvent{id: $id, ref: $userRef, type: $type, topicRef: $topicRef}';
  }
}
