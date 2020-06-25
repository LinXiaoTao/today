import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:today/data/model/models.dart';

@immutable
abstract class MessageRelatedEvent extends Equatable {}

class FetchMessageRelatedListEvent extends MessageRelatedEvent {
  final String id;
  final String pageName;
  final MessageType type;

  FetchMessageRelatedListEvent(this.id,
      {this.pageName = '', this.type = MessageType.ORIGINAL_POST})
      : super();

  @override
  String toString() {
    return 'FetchMessageRelatedListEvent{id: $id, pageName: $pageName, type: $type}';
  }

  @override
  List<Object> get props => [id, pageName];
}
