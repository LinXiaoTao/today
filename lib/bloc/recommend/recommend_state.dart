import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:today/data/model/models.dart';

@immutable
abstract class RecommendState extends Equatable {}

class InitialRecommendState extends RecommendState {
  @override
  List<Object> get props => [];
}

class LoadedRecommendState extends RecommendState {
  final List<Message> recommendList;
  final bool hasLoadMore;
  final String toastMsg;

  LoadedRecommendState(
      {this.recommendList = const [],
      this.hasLoadMore = true,
      this.toastMsg = ''})
      : super();

  @override
  String toString() {
    return 'LoadedRecommendState{recommendList: $recommendList, hasLoadMore: $hasLoadMore}';
  }

  @override
  List<Object> get props => [recommendList, hasLoadMore, toastMsg];
}
