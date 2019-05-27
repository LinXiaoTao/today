import 'package:scoped_model/scoped_model.dart';
import 'package:today/data/model/init.dart';
import 'package:today/data/network/request.dart';
import 'package:flutter/widgets.dart';

class RecommendModel extends Model {
  final List<RecommendItem> _recommendList = [];
  final List<RecommendHeadItem> _recommendHeadList = [];
  RecommendFeed _recommendFeed;
  ShortcutsData _shortcutsData;
  SearchPlaceholder _searchPlaceholder;

  ShortcutsData get shortcutsData {
    return _shortcutsData;
  }

  List<RecommendItem> get recommendData {
    return _recommendList;
  }

  List<RecommendHeadItem> get recommendHeadData {
    return _recommendHeadList;
  }

  RecommendFeed get recommendFee {
    return _recommendFeed;
  }

  SearchPlaceholder get searchPlaceholder {
    return _searchPlaceholder;
  }

  static RecommendModel of(BuildContext context,
      {bool rebuildOnChange = false}) {
    return ScopedModel.of(context, rebuildOnChange: rebuildOnChange);
  }

  /// 推荐数据
  /// 包括列表和圈子
  requestRecommendData({bool loadMore = false}) async {
    _recommendFeed = await ApiRequest.recommendFeedList(
        loadMoreKey: (loadMore ? _recommendFeed.loadMoreKey : null));
    if (!loadMore) {
      _shortcutsData = await ApiRequest.shortcutsList();
      _searchPlaceholder = await ApiRequest.searchPlaceholder();
    }

    _recommendHeadList.clear();
    if (!loadMore) {
      _recommendList.clear();
    }
    if (_recommendFeed.data.isNotEmpty &&
        _recommendFeed.data[0].type == "HEADLINE_RECOMMENDATION") {
      _recommendHeadList.addAll(_recommendFeed.data[0].items);
      _recommendFeed.data.removeAt(0);
    }
    _recommendList.addAll(_recommendFeed.data);
    notifyListeners();
  }
}
