import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:today/data/model/models.dart';

@immutable
abstract class CommentListState extends Equatable {
  CommentListState([List props = const []]) : super(props);
}

class InitialCommentListState extends CommentListState {}

class LoadedCommentListState extends CommentListState {
  final List<Comment> commentList;
  final bool hasLoadMore;
  final List<Comment> hotCommentList;

  LoadedCommentListState(this.commentList, this.hotCommentList,
      {this.hasLoadMore = true})
      : super([commentList, hasLoadMore, hotCommentList]);

  @override
  String toString() {
    return 'LoadedCommentListState{commentList: $commentList, hasLoadMore: $hasLoadMore, hotCommentList: $hotCommentList}';
  }
}
