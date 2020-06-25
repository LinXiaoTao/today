import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:today/data/model/models.dart';

@immutable
abstract class RecommendState extends Equatable {
  RecommendState([List props = const []]) : super(props);
}

class InitialRecommendState extends RecommendState {}

class LoadedRecommendState extends RecommendState {
  final List<Message> recommendList;
  final bool hasLoadMore;
  final String toastMsg;

  LoadedRecommendState(
      {this.recommendList = const [],
      this.hasLoadMore = true,
      this.toastMsg = ''})
      : super([recommendList, hasLoadMore, toastMsg]);

  @override
  String toString() {
    return 'LoadedRecommendState{recommendList: $recommendList, hasLoadMore: $hasLoadMore}';
  }
}
