import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CommentListEvent extends Equatable {}

class FetchCommentListEvent extends CommentListEvent {
  final String targetId;
  final String targetType;
  final bool loadMore;

  FetchCommentListEvent(this.targetId,
      {this.targetType = '', this.loadMore = false});

  @override
  String toString() {
    return 'FetchCommentListEvent{targetId: $targetId, targetType: $targetType, loadMore: $loadMore}';
  }

  @override
  List<Object> get props => [targetId, targetType, loadMore];
}
