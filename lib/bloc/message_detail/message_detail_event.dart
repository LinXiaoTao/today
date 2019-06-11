import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:today/data/model/models.dart';

@immutable
abstract class MessageDetailEvent extends Equatable {
  MessageDetailEvent([List props = const []]) : super(props);
}

class FetchMessageDetailEvent extends MessageDetailEvent {
  final String id;
  final String ref;
  final MessageType type;

  FetchMessageDetailEvent(this.id,
      {this.ref = '', this.type = MessageType.ORIGINAL_POST})
      : super([id, ref]);

  @override
  String toString() {
    return 'FetchMessageDetailEvent{id: $id, ref: $ref, type: $type}';
  }
}
