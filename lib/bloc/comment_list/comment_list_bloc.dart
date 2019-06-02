import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:today/data/model/models.dart';
import 'package:today/data/network/request.dart';

class CommentListBloc extends Bloc<CommentListEvent, CommentListState> {
  CommentList _commentData;
  final List<Comment> _commentList = [];
  final List<Comment> _hotCommentList = [];

  @override
  CommentListState get initialState => InitialCommentListState();

  @override
  Stream<CommentListState> mapEventToState(
    CommentListEvent event,
  ) async* {
    if (event is FetchCommentListEvent) {
      List<Comment> commentList = [];

      if (event.loadMore) {
        commentList.addAll(_commentList);
      }

      if (event.loadMore && _commentData.loadMoreKey.isEmpty) {
        /// 没有更多数据了
        yield LoadedCommentListState(commentList, _hotCommentList,
            hasLoadMore: _commentData.loadMoreKey.isNotEmpty);
        return;
      }

      _commentData = await ApiRequest.commentList(
          event.targetId, event.targetType,
          loadMoreKey: event.loadMore ? _commentData.loadMoreKey : null);

      _hotCommentList.addAll(_commentData.hotComments);

      commentList.addAll(_commentData.data);

      /// cache
      _commentList.clear();
      _commentList.addAll(commentList);

      yield LoadedCommentListState(commentList, _hotCommentList,
          hasLoadMore: _commentData.loadMoreKey.isNotEmpty);
    }
  }
}
