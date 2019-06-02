import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MessageDetailEvent extends Equatable {
  MessageDetailEvent([List props = const []]) : super(props);
}

class FetchMessageDetailEvent extends MessageDetailEvent {
  final String id;
  final String ref;

  FetchMessageDetailEvent(this.id, {this.ref = ''}) : super([id, ref]);

  @override
  String toString() {
    return 'FetchMessageDetailEvent{id: $id, ref: $ref}';
  }
}
