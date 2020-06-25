import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:today/data/model/models.dart';

@immutable
abstract class CommentListState extends Equatable {}

class InitialCommentListState extends CommentListState {
  @override
  List<Object> get props => [];
}

class LoadedCommentListState extends CommentListState {
  final List<Comment> commentList;
  final bool hasLoadMore;
  final List<Comment> hotCommentList;

  LoadedCommentListState(this.commentList, this.hotCommentList,
      {this.hasLoadMore = true});

  @override
  String toString() {
    return 'LoadedCommentListState{commentList: $commentList, hasLoadMore: $hasLoadMore, hotCommentList: $hotCommentList}';
  }

  @override
  List<Object> get props => [commentList, hasLoadMore, hotCommentList];
}
