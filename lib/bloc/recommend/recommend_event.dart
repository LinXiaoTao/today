import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RecommendEvent extends Equatable {
  RecommendEvent([List props = const []]) : super(props);
}

class FetchRecommendEvent extends RecommendEvent {
  final bool loadMore;

  FetchRecommendEvent({this.loadMore = false});

  @override
  String toString() {
    return 'FetchRecommendEvent{}';
  }
}
