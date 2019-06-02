import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CommentDetailEvent extends Equatable {
  CommentDetailEvent([List props = const []]) : super(props);
}

class FetchCommentDetailEvent extends CommentDetailEvent {
  final String id;
  final String targetType;

  FetchCommentDetailEvent(this.id, {this.targetType = ''})
      : super([id, targetType]);

  @override
  String toString() {
    return 'FetchCommentDetailEvent{id: $id, targetType: $targetType}';
  }
}
