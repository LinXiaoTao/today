import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:today/data/model/init.dart';
import 'package:today/data/network/request.dart';

class CommentModel extends Model {
  CommentList _commentList;
  final List<Comment> _commentData = [];
  final List<Comment> _commentReplyData = [];
  Comment _commentDetail;
  CommentList _commentReplyList;

  CommentList get commentList {
    return _commentList;
  }

  List<Comment> get commentData {
    return _commentData;
  }

  List<Comment> get commentReplyData {
    return _commentReplyData;
  }

  Comment get commentDetail {
    return _commentDetail;
  }

  CommentList get commentReplyList {
    return _commentReplyList;
  }

  static CommentModel of(BuildContext context, {bool rebuildOnChange = false}) {
    return ScopedModel.of(context, rebuildOnChange: rebuildOnChange);
  }

  requestCommentList(String targetId, String targetType,
      {bool loadMore = false}) async {
    if (loadMore && _commentList.loadMoreKey.isEmpty) {
      notifyListeners();
      return;
    }

    _commentList = await ApiRequest.commentList(targetId, targetType,
        loadMoreKey: (loadMore ? _commentList.loadMoreKey : null));

    if (!loadMore) {
      _commentData.clear();
    }
    _commentData.addAll(_commentList.data);
    notifyListeners();
  }

  requestCommentDetail(String id, String targetType) async {
    _commentDetail = await ApiRequest.commentDetail(id, targetType);
    notifyListeners();
  }

  requestCommentReply(String primaryCommentId, String targetType,
      {String order = 'LIKES', bool loadMore = false}) async {
    if (!loadMore) {
      _commentReplyData.clear();
    } else if (_commentReplyList.loadMoreKey.isEmpty) {
      notifyListeners();
      return;
    }

    _commentReplyList = await ApiRequest.replyCommentList(
        primaryCommentId, targetType,
        order: order,
        loadMoreKey: (loadMore ? _commentReplyList.loadMoreKey : null));

    _commentReplyData.addAll(_commentReplyList.data);
    notifyListeners();
  }
}
