import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:today/ui/ui_base.dart';

class TopicListPage extends StatefulWidget {
  @override
  _TopicListPageState createState() => _TopicListPageState();
}

class _TopicListPageState extends State<TopicListPage>
    with AfterLayoutMixin<TopicListPage> {
  final TopicListBloc _bloc = TopicListBloc();

  @override
  void afterFirstLayout(BuildContext context) {
    _bloc.dispatch(FetchTopicTabsEvent());
    _bloc.state.listen((state) {
      if (state is LoadedTopicTabsState) {
        /// 加载 tabs 成功
        if (state.items.isNotEmpty) {
          _bloc.dispatch(FetchTopicListEvent(state.items.first.alias));
        }
      }

      if (state is ChangeSubscriptionState) {
        /// 刷新首页【我的圈子】

        final bloc = BlocProvider.of<ShortcutBloc>(context);
        bloc?.dispatch(FetchShortcutEvent());
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NormalPage(
      body: Row(
        children: <Widget>[
          _TabsWidget(_bloc),
          Expanded(child: _TopicListWidget(_bloc)),
        ],
      ),
      title: NormalTitle('发现圈子'),
      actions: <Widget>[IconButton(icon: Icon(Icons.search), onPressed: () {})],
    );
  }
}

class _TabsWidget extends StatefulWidget {
  final TopicListBloc bloc;

  _TabsWidget(this.bloc);

  @override
  __TabsWidgetState createState() => __TabsWidgetState();
}

class __TabsWidgetState extends State<_TabsWidget> {
  int _curIndex = 0;

  final StreamController<int> _curIndexController = StreamController();
  Stream<int> _curIndexStream;

  @override
  void initState() {
    _curIndexStream = _curIndexController.stream.asBroadcastStream();
    super.initState();
  }

  @override
  void dispose() {
    _curIndexController?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: widget.bloc,
      builder: (_, TopicListState state) {
        if (state is LoadedTopicTabsState) {
          return SizedBox(
            width: 90,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemBuilder: (_, index) {
                TopicTab tab = state.items[index];
                return GestureDetector(
                  onTap: () {
                    if (index != _curIndex) {
                      _curIndex = index;
                      _curIndexController.sink.add(_curIndex);
                      widget.bloc.dispatch(FetchTopicListEvent(tab.alias));
                    }
                  },
                  child: StreamBuilder<int>(
                    builder: (_, snapshot) {
                      var bg = Colors.transparent;

                      if (_curIndex == index) {
                        bg = Colors.white;
                      }

                      return Container(
                        color: bg,
                        padding: EdgeInsets.symmetric(
                            vertical: AppDimensions.primaryPadding * 1.5),
                        child: Center(
                          child: Text(
                            tab.name,
                            style: TextStyle(color: AppColors.primaryTextColor),
                          ),
                        ),
                      );
                    },
                    stream: _curIndexStream,
                  ),
                );
              },
              itemCount: state.items.length,
            ),
          );
        }
        return SpinKitThreeBounce(
          size: 20,
          color: Colors.grey,
          duration: Duration(milliseconds: 1000),
        );
      },
      condition: (pre, cur) {
        return cur is LoadedTopicTabsState || cur is InitialTopicListState;
      },
    );
  }
}

class _TopicListWidget extends StatefulWidget {
  final TopicListBloc bloc;

  _TopicListWidget(this.bloc);

  @override
  __TopicListWidgetState createState() => __TopicListWidgetState();
}

class __TopicListWidgetState extends State<_TopicListWidget> {
  String _curAlias = '';
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    widget.bloc.event.listen((event) {
      if (event is FetchTopicListEvent) {
        _curAlias = event.type;
      }
    });
    widget.bloc.state.listen((state) {
      if (state is LoadedTopicListState &&
          !state.loadMore &&
          _scrollController.positions.isNotEmpty) {
        _scrollController.jumpTo(0);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, layout) {
      return EasyRefresh(
        refreshFooter: BallPulseFooter(
          key: GlobalKey(),
          backgroundColor: Colors.transparent,
          color: AppColors.accentColor,
        ),
        firstRefresh: false,
        loadMore: () {
          widget.bloc.dispatch(FetchTopicListEvent(_curAlias, loadMore: true));
        },
        child: BlocBuilder(
          bloc: widget.bloc,
          builder: (_, TopicListState state) {
            if (state is LoadedTopicListState) {
              return SizedBox(
                height: layout.maxHeight,
                child: ListView.separated(
                    controller: _scrollController,
                    itemBuilder: (_, index) {
                      Topic topic = state.items[index];

                      return Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                            horizontal: AppDimensions.primaryPadding),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: AppDimensions.primaryPadding,
                            ),
                            Row(
                              children: <Widget>[
                                AppNetWorkImage(
                                  src: topic.squarePicture.thumbnailUrl,
                                  width: 45,
                                  height: 45,
                                  fit: BoxFit.contain,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                SizedBox(
                                  width: AppDimensions.primaryPadding,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        topic.content,
                                        style: TextStyle(
                                            color: AppColors.primaryTextColor,
                                            fontSize: 15),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        '${topic.subscribersCountText}人加入',
                                        style: TextStyle(
                                            color: AppColors.tipsTextColor,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: AppDimensions.primaryPadding,
                                ),
                                _ChangeSubscriptionStateWidget(
                                    bloc: widget.bloc, topic: topic),
                              ],
                            ),
                            LayoutBuilder(builder: (_, layout) {
                              return Container(
                                width: layout.maxWidth,
                                margin: EdgeInsets.only(
                                    top: AppDimensions.primaryPadding),
                                padding: EdgeInsets.symmetric(
                                    vertical: AppDimensions.primaryPadding,
                                    horizontal: AppDimensions.primaryPadding),
                                color: AppColors.topicBackground,
                                child: Text(
                                  topic.briefIntro,
                                  style: TextStyle(
                                      color: AppColors.normalTextColor,
                                      fontSize: 13),
                                ),
                              );
                            }),
                            SizedBox(
                              height: AppDimensions.primaryPadding,
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (_, index) {
                      return Divider(
                        color: AppColors.dividerGrey,
                        height: 0.5,
                        indent: AppDimensions.primaryPadding,
                      );
                    },
                    itemCount: state.items.length),
              );
            }
            return PageLoadingWidget();
          },
          condition: (pre, cur) {
            return cur is LoadedTopicListState || cur is InitialTopicListState;
          },
        ),
      );
    });
  }
}

class _ChangeSubscriptionStateWidget extends StatefulWidget {
  final TopicListBloc bloc;

  const _ChangeSubscriptionStateWidget({
    Key key,
    @required this.bloc,
    @required this.topic,
  }) : super(key: key);

  final Topic topic;

  @override
  __ChangeSubscriptionStateWidgetState createState() =>
      __ChangeSubscriptionStateWidgetState();
}

class __ChangeSubscriptionStateWidgetState
    extends State<_ChangeSubscriptionStateWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: widget.bloc,
        condition: (pre, cur) {
          return cur is ChangeSubscriptionState;
        },
        builder: (_, state) {
          return GestureDetector(
            onTap: () {
              widget.bloc.dispatch(ChangeSubscriptionStateEvent(widget.topic));
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              decoration: BoxDecoration(
                  color: (widget.topic.subscribersState
                      ? Colors.grey[400]
                      : AppColors.blue),
                  borderRadius: BorderRadius.circular(12)),
              width: 60,
              height: 26,
              child: Center(
                child: Text(
                  (widget.topic.subscribersState ? '已加入' : '加入'),
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ),
          );
        });
  }
}
