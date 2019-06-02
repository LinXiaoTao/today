import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:today/data/network/request.dart';

class RecommendBloc extends Bloc<RecommendEvent, RecommendState> {
  RecommendFeed _recommendFeed;
  final List<RecommendItem> _recommendList = [];

  List<RecommendItem> get recommendList {
    return _recommendList;
  }

  @override
  RecommendState get initialState => InitialRecommendState();

  @override
  Stream<RecommendState> mapEventToState(
    RecommendEvent event,
  ) async* {
    if (event is FetchRecommendEvent) {
      yield LoadedRecommendState(
          recommendList: await _fetchRecommendData(loadMore: event.loadMore),
          hasLoadMore: _recommendFeed.loadMoreKey != null,
          toastMsg: _recommendFeed.toastMessage);
    }
  }

  Future<List<RecommendItem>> _fetchRecommendData(
      {bool loadMore = false}) async {
    List<RecommendItem> recommendItems = [];

    if (loadMore) {
      recommendItems.addAll(_recommendList);
    }

    if (loadMore && _recommendFeed.loadMoreKey == null) {
      /// 没有更多数据了
      return recommendItems;
    }

    _recommendFeed = await ApiRequest.recommendFeedList(
        loadMoreKey: loadMore ? _recommendFeed.loadMoreKey : null);

    _recommendFeed.data.removeWhere((item) {
      return item.type == 'HEADLINE_RECOMMENDATION';
    });

    recommendItems.addAll(_recommendFeed.data);

    /// cache
    _recommendList.clear();
    _recommendList.addAll(recommendItems);

    return recommendItems;
  }
}
