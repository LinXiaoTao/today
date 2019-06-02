import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:today/data/model/models.dart';

@immutable
abstract class MessageRelatedState extends Equatable {
  MessageRelatedState([List props = const []]) : super(props);
}

class InitialMessageRelatedState extends MessageRelatedState {}

class LoadedMessageRelatedListState extends MessageRelatedState {
  final List<Message> messageList;

  LoadedMessageRelatedListState({this.messageList = const []})
      : super([messageList]);

  @override
  String toString() {
    return 'LoadedMessageRelatedListState{messageList: $messageList}';
  }
}
