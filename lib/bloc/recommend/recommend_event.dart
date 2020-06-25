import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RecommendEvent extends Equatable {}

class FetchRecommendEvent extends RecommendEvent {
  final bool loadMore;

  FetchRecommendEvent({this.loadMore = false});

  @override
  String toString() {
    return 'FetchRecommendEvent{}';
  }

  @override
  List<Object> get props => [];
}
