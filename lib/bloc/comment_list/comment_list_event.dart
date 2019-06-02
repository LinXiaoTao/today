import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CommentListEvent extends Equatable {
  CommentListEvent([List props = const []]) : super(props);
}

class FetchCommentListEvent extends CommentListEvent {
  final String targetId;
  final String targetType;
  final bool loadMore;

  FetchCommentListEvent(this.targetId,
      {this.targetType = '', this.loadMore = false})
      : super([targetId, targetType, loadMore]);

  @override
  String toString() {
    return 'FetchCommentListEvent{targetId: $targetId, targetType: $targetType, loadMore: $loadMore}';
  }
}
