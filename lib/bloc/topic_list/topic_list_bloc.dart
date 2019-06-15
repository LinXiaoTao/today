import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:today/data/network/request.dart';

class TopicListBloc extends Bloc<TopicListEvent, TopicListState> {
  final List<Topic> _items = [];
  TopicList _topicList;

  @override
  TopicListState get initialState => InitialTopicListState();

  @override
  Stream<TopicListState> mapEventToState(
    TopicListEvent event,
  ) async* {
    if (event is FetchTopicTabsEvent) {
      yield LoadedTopicTabsState(await ApiRequest.topicListTabs());
    } else if (event is FetchTopicListEvent) {
      List<Topic> items = [];

      if (!event.loadMore) {
        _items.clear();
      }
      _topicList = await ApiRequest.topicListTopics(
          loadMoreKey: (event.loadMore ? _topicList.loadMoreKey : -1),
          type: event.type);

      _items.addAll(_topicList.data);
      items.addAll(_items);

      yield LoadedTopicListState(items: items, loadMore: event.loadMore);
    } else if (event is ChangeSubscriptionStateEvent) {
      bool success = await ApiRequest.changeSubscriptionState(
          topicObjectId: event.topic.id,
          ref: event.topic.ref,
          subscribed: !event.topic.subscribersState,
          pageName: 'discover_topic',
          push: true);
      if (success) {
        event.topic.subscribersState = !event.topic.subscribersState;
        yield ChangeSubscriptionState(event.topic);
      }
    }
  }
}
