import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CommentDetailEvent extends Equatable {}

class FetchCommentDetailEvent extends CommentDetailEvent {
  final String id;
  final String targetType;

  FetchCommentDetailEvent(this.id, {this.targetType = ''});

  @override
  String toString() {
    return 'FetchCommentDetailEvent{id: $id, targetType: $targetType}';
  }

  @override
  List<Object> get props => [id, targetType];
}
