import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CommentReplyEvent extends Equatable {
  CommentReplyEvent([List props = const []]) : super(props);
}

class FetchCommentReplyEvent extends CommentReplyEvent {
  final String primaryCommentId;
  final String targetType;

  final String order;

  final bool loadMore;

  FetchCommentReplyEvent(this.primaryCommentId,
      {this.targetType = '', this.order = 'LIKES', this.loadMore = false})
      : super([primaryCommentId, targetType, order, loadMore]);

  @override
  String toString() {
    return 'FetchCommentReplyEvent{primaryCommentId: $primaryCommentId, targetType: $targetType, order: $order, loadMore: $loadMore}';
  }
}
