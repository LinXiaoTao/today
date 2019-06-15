import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:today/data/model/models.dart';

@immutable
abstract class TopicListState extends Equatable {
  TopicListState([List props = const []]) : super(props);
}

class InitialTopicListState extends TopicListState {}

class LoadedTopicTabsState extends TopicListState {
  final List<TopicTab> items;

  LoadedTopicTabsState(this.items) : super([items]);

  @override
  String toString() {
    return 'LoadedTopicTabsState{items: $items}';
  }
}

class LoadedTopicListState extends TopicListState {
  final List<Topic> items;
  final bool loadMore;

  LoadedTopicListState({this.items, this.loadMore = false})
      : super([items, loadMore]);

  @override
  String toString() {
    return 'LoadedTopicListState{items: $items, loadMore: $loadMore}';
  }
}

class ChangeSubscriptionState extends TopicListState {
  final Topic topic;

  ChangeSubscriptionState(this.topic) : super([topic]);

  @override
  String toString() {
    return 'ChangeSubscriptionState{topic: $topic}';
  }
}
