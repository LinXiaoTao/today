import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:today/data/network/request.dart';

class CommentReplyBloc extends Bloc<CommentReplyEvent, CommentReplyState> {
  CommentList _commentData;
  final List<Comment> _commentList = [];

  @override
  CommentReplyState get initialState => InitialCommentReplyState();

  @override
  Stream<CommentReplyState> mapEventToState(
    CommentReplyEvent event,
  ) async* {
    if (event is FetchCommentReplyEvent) {
      List<Comment> commentList = [];

      if (event.loadMore) {
        commentList.addAll(_commentList);
      }

      if (event.loadMore && _commentData.loadMoreKey.isEmpty) {
        /// 没有更多数据了
        yield LoadedCommentReplyState(commentList, hasLoadMore: false);
        return;
      }

      _commentData = await ApiRequest.replyCommentList(
          event.primaryCommentId, event.targetType,
          order: event.order,
          loadMoreKey: event.loadMore ? _commentData.loadMoreKey : null);

      commentList.addAll(_commentData.data);

      _commentList.clear();
      _commentList.addAll(commentList);

      yield LoadedCommentReplyState(commentList,
          hasLoadMore: _commentData.loadMoreKey.isNotEmpty);
    }
  }
}
