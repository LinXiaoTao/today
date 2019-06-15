import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:today/data/model/models.dart';

@immutable
abstract class TopicListEvent extends Equatable {
  TopicListEvent([List props = const []]) : super(props);
}

class FetchTopicListEvent extends TopicListEvent {
  final String type;
  final bool loadMore;

  FetchTopicListEvent(this.type, {this.loadMore = false})
      : super([type, loadMore]);

  @override
  String toString() {
    return 'FetchTopicListEvent{type: $type, loadMore: $loadMore}';
  }
}

class FetchTopicTabsEvent extends TopicListEvent {
  @override
  String toString() {
    return 'FetchTopicTabsEvent{}';
  }
}

class ChangeSubscriptionStateEvent extends TopicListEvent {
  final Topic topic;

  ChangeSubscriptionStateEvent(this.topic) : super([topic]);

  @override
  String toString() {
    return 'ChangeSubscriptionStateEvent{topic: $topic}';
  }
}
