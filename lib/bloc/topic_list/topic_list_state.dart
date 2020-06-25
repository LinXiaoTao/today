import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:today/data/model/models.dart';

@immutable
abstract class TopicListState extends Equatable {}

class InitialTopicListState extends TopicListState {
  @override
  List<Object> get props => [];
}

class LoadedTopicTabsState extends TopicListState {
  final List<TopicTab> items;

  LoadedTopicTabsState(this.items) : super();

  @override
  List<Object> get props => [items];

  @override
  String toString() {
    return 'LoadedTopicTabsState{items: $items}';
  }
}

class LoadedTopicListState extends TopicListState {
  final List<Topic> items;
  final bool loadMore;

  LoadedTopicListState({this.items, this.loadMore = false}) : super();

  @override
  String toString() {
    return 'LoadedTopicListState{items: $items, loadMore: $loadMore}';
  }

  @override
  List<Object> get props => [items, loadMore];
}

class ChangeSubscriptionState extends TopicListState {
  final Topic topic;

  ChangeSubscriptionState(this.topic) : super();

  @override
  String toString() {
    return 'ChangeSubscriptionState{topic: $topic}';
  }

  @override
  List<Object> get props => [topic];
}
