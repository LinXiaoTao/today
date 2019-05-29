import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:today/data/model/init.dart';
import 'package:today/data/network/request.dart';

class CommentModel extends Model {
  CommentList _commentList;
  final List<Comment> _commentData = [];

  CommentList get commentList {
    return _commentList;
  }

  List<Comment> get commentData {
    return _commentData;
  }

  static CommentModel of(BuildContext context, {bool rebuildOnChange = false}) {
    return ScopedModel.of(context, rebuildOnChange: rebuildOnChange);
  }

  requestCommentList(String targetId, String targetType,
      {bool loadMore = false}) async {
    _commentList = await ApiRequest.commentList(targetId, targetType,
        loadMoreKey: (loadMore ? _commentList.loadMoreKey : null));

    if (!loadMore) {
      _commentData.clear();
    }
    _commentData.addAll(_commentList.data);
    notifyListeners();
  }
}
