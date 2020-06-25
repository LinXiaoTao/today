import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:today/data/model/models.dart';

@immutable
abstract class MessageRelatedState extends Equatable {}

class InitialMessageRelatedState extends MessageRelatedState {
  @override
  List<Object> get props => [];
}

class LoadedMessageRelatedListState extends MessageRelatedState {
  final List<Message> messageList;

  LoadedMessageRelatedListState({this.messageList = const []}) : super();

  @override
  String toString() {
    return 'LoadedMessageRelatedListState{messageList: $messageList}';
  }

  @override
  List<Object> get props => [messageList];
}
