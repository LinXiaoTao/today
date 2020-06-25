import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:today/data/model/models.dart';

@immutable
abstract class TopicListEvent extends Equatable {}

class FetchTopicListEvent extends TopicListEvent {
  final String type;
  final bool loadMore;

  FetchTopicListEvent(this.type, {this.loadMore = false}) : super();

  @override
  String toString() {
    return 'FetchTopicListEvent{type: $type, loadMore: $loadMore}';
  }

  @override
  List<Object> get props => [type, loadMore];
}

class FetchTopicTabsEvent extends TopicListEvent {
  @override
  String toString() {
    return 'FetchTopicTabsEvent{}';
  }

  @override
  List<Object> get props => [];
}

class ChangeSubscriptionStateEvent extends TopicListEvent {
  final Topic topic;

  ChangeSubscriptionStateEvent(this.topic) : super();

  @override
  String toString() {
    return 'ChangeSubscriptionStateEvent{topic: $topic}';
  }

  @override
  List<Object> get props => [topic];
}
