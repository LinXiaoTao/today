import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:today/data/model/models.dart';

@immutable
abstract class MessageDetailEvent extends Equatable {}

class FetchMessageDetailEvent extends MessageDetailEvent {
  final String id;
  final String userRef;
  final MessageType type;
  final String topicRef;

  FetchMessageDetailEvent(this.id,
      {this.userRef = '',
      this.topicRef = '',
      this.type = MessageType.ORIGINAL_POST})
      : super();

  @override
  String toString() {
    return 'FetchMessageDetailEvent{id: $id, ref: $userRef, type: $type, topicRef: $topicRef}';
  }

  @override
  List<Object> get props => [id, userRef, topicRef];
}
