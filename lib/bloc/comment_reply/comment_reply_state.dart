import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:today/data/model/models.dart';

@immutable
abstract class CommentReplyState extends Equatable {
  CommentReplyState([List props = const []]) : super(props);
}

class InitialCommentReplyState extends CommentReplyState {}

class LoadedCommentReplyState extends CommentReplyState {
  final List<Comment> comment;

  final bool hasLoadMore;

  LoadedCommentReplyState(this.comment, {this.hasLoadMore = true})
      : super([comment, hasLoadMore]);

  @override
  String toString() {
    return 'LoadedCommentReplyState{comment: $comment, hasLoadMore: $hasLoadMore}';
  }
}
