import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:today/data/model/models.dart';

@immutable
abstract class MessageDetailState extends Equatable {
}

class InitialMessageDetailState extends MessageDetailState {
  @override
  List<Object> get props => [];
}

class LoadedMessageDetailState extends MessageDetailState {
  final Message message;

  LoadedMessageDetailState(this.message) : super();

  @override
  String toString() {
    return 'LoadedMessageDetailState{message: $message}';
  }

  @override
  List<Object> get props => throw [message];
}
