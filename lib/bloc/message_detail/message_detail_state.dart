import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:today/data/model/models.dart';

@immutable
abstract class MessageDetailState extends Equatable {
  MessageDetailState([List props = const []]) : super(props);
}

class InitialMessageDetailState extends MessageDetailState {}

class LoadedMessageDetailState extends MessageDetailState {
  final Message message;

  LoadedMessageDetailState(this.message) : super([message]);

  @override
  String toString() {
    return 'LoadedMessageDetailState{message: $message}';
  }
}
