import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:today/data/model/models.dart';

@immutable
abstract class CommentReplyState extends Equatable {}

class InitialCommentReplyState extends CommentReplyState {
  @override
  List<Object> get props => [];
}

class LoadedCommentReplyState extends CommentReplyState {
  final List<Comment> comment;

  final bool hasLoadMore;

  LoadedCommentReplyState(this.comment, {this.hasLoadMore = true}) : super();

  @override
  String toString() {
    return 'LoadedCommentReplyState{comment: $comment, hasLoadMore: $hasLoadMore}';
  }

  @override
  List<Object> get props => [comment, hasLoadMore];
}
