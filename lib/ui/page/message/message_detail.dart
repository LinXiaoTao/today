import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:intl/intl.dart';
import 'package:today/ui/ui_base.dart';
import 'package:today/widget/message.dart';

final DateFormat _dateFormat = DateFormat('MM/dd HH:mm');

/// 消息详情
class MessageDetailPage extends StatefulWidget {
  final String id;
  final String userRef;
  final String pageName;
  final MessageType type;
  final String topicRef;

  MessageDetailPage(
      {@required this.id,
      this.userRef = '',
      this.pageName,
      this.type = MessageType.ORIGINAL_POST,
      this.topicRef = ''});

  @override
  State<StatefulWidget> createState() {
    return _MessageDetailState();
  }
}

class _MessageDetailState extends State<MessageDetailPage>
    with AfterLayoutMixin<MessageDetailPage> {
  final MessageDetailBloc _detailBloc = MessageDetailBloc();
  final MessageRelatedBloc _relatedBloc = MessageRelatedBloc();
  final CommentListBloc _commentListBloc = CommentListBloc();

  final GlobalKey<PhoenixHeaderState> _refreshHeaderKey = GlobalKey();
  final GlobalKey<BallPulseFooterState> _loadMoreFooterKey = GlobalKey();
  final GlobalKey<__CommentListWidgetState> _commentListKey = GlobalKey();

  final StreamController<double> _scrollController = StreamController();
  Stream<double> _scrollStream;

  @override
  void initState() {
    _scrollStream = _scrollController.stream;
    super.initState();
  }

  @override
  void dispose() {
    _detailBloc?.dispose();
    _relatedBloc?.dispose();
    _commentListBloc?.dispose();
    _scrollController?.close();
    super.dispose();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _detailBloc.dispatch(FetchMessageDetailEvent(widget.id,
        userRef: widget.userRef, topicRef: widget.topicRef, type: widget.type));
    _relatedBloc.dispatch(FetchMessageRelatedListEvent(widget.id,
        pageName: widget.pageName, type: widget.type));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _detailBloc,
      builder: (_, MessageDetailState state) {
        if (state is LoadedMessageDetailState) {
          Message message = state.message;
          UserInfo user = message.user;
          return NormalPage(
            titleSpacing: 0,
            title: StreamBuilder(
              stream: _scrollStream,
              builder: (_, snapshot) {
                double value = 0;
                if (snapshot.hasData) {
                  value = snapshot.data;
                }

                if (value > 100 && user != null) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            AvatarWidget(
                              user,
                              jumpDetail: false,
                              size: 32,
                            ),
                            SizedBox(
                              width: AppDimensions.primaryPadding,
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 32,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    ScreenNameWidget(
                                      user: user,
                                      textColor: AppColors.primaryTextColor,
                                      fontSize: 10,
                                      showVerify: false,
                                    ),
                                    Text(
                                      '${user.statsCount.followedCount}人关注',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: AppColors.tipsTextColor,
                                          fontSize: 10),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 28,
                        margin: EdgeInsets.symmetric(
                            horizontal: AppDimensions.primaryPadding),
                        decoration: BoxDecoration(
                            color: AppColors.blue,
                            borderRadius: BorderRadius.circular(18)),
                        child: Center(
                          child: Text(
                            '关注',
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  );
                }

                return NormalTitle('动态详情');
              },
            ),
            body: NotificationListener(
              onNotification: (ScrollNotification notification) {
                if (notification.metrics != null &&
                    notification.metrics.axis == Axis.vertical) {
                  _scrollController.sink.add(notification.metrics.extentBefore);
                }
              },
              child: EasyRefresh(
                  refreshHeader: PhoenixHeader(
                    key: _refreshHeaderKey,
                  ),
                  refreshFooter: BallPulseFooter(
                    key: _loadMoreFooterKey,
                    backgroundColor: Colors.transparent,
                    color: AppColors.accentColor,
                  ),
                  autoLoad: true,
                  onRefresh: () {
                    _detailBloc.dispatch(FetchMessageDetailEvent(widget.id,
                        userRef: widget.userRef,
                        topicRef: widget.topicRef,
                        type: widget.type));
                    _relatedBloc.dispatch(FetchMessageRelatedListEvent(
                        widget.id,
                        pageName: widget.pageName,
                        type: widget.type));
                    _commentListKey.currentState.refreshData();
                  },
                  loadMore: () {
                    _commentListKey.currentState.refreshData(loadMore: true);
                  },
                  firstRefresh: false,
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        child: Container(
                          color: Colors.white,
                          margin: EdgeInsets.only(
                              bottom: AppDimensions.primaryPadding),
                          padding: EdgeInsets.symmetric(
                              horizontal: AppDimensions.primaryPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: AppDimensions.primaryPadding,
                              ),
                              Builder(builder: (_) {
                                if (user == null) return SizedBox();

                                return Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            AvatarWidget(user),
                                            SizedBox(
                                              width:
                                                  AppDimensions.primaryPadding,
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              LayoutBuilder(
                                                  builder: (_, layout) {
                                                if (user != null) {
                                                  return Column(
                                                    children: <Widget>[
                                                      ScreenNameWidget(
                                                          user: user),
                                                      SizedBox(
                                                        height: AppDimensions
                                                            .smallPadding,
                                                      ),
                                                    ],
                                                  );
                                                }

                                                return SizedBox();
                                              }),
                                              Row(
                                                children: <Widget>[
                                                  Text(
                                                    _dateFormat.format(
                                                        DateTime.parse(message
                                                                .createdAt)
                                                            .toLocal()),
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: AppColors
                                                            .tipsTextColor),
                                                  ),
                                                  Builder(builder: (_) {
                                                    if (message.poi == null)
                                                      return SizedBox();

                                                    return Expanded(
                                                      child: Row(
                                                        children: <Widget>[
                                                          SizedBox(
                                                            width: AppDimensions
                                                                .smallPadding,
                                                          ),
                                                          Image.asset(
                                                              'images/ic_personaltab_activity_add_location.png'),
                                                          SizedBox(
                                                            width: AppDimensions
                                                                    .smallPadding /
                                                                2,
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              message.poi.name,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: AppColors
                                                                      .tipsTextColor),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  }),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: AppColors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: GestureDetector(
                                            onTap: () {},
                                            behavior: HitTestBehavior.opaque,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5, horizontal: 15),
                                              child: Text(
                                                '关注',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: AppDimensions.primaryPadding /
                                              2 *
                                              3,
                                        ),
                                        Image.asset(
                                            'images/ic_messages_collect_unselected.png'),
                                      ],
                                    ),
                                    SizedBox(
                                      height: AppDimensions.primaryPadding,
                                    ),
                                  ],
                                );
                              }),
                              RichTextWidget(
                                message,
                                showFullContent: true,
                              ),
                              Builder(builder: (_) {
                                if (message.content.isEmpty) return SizedBox();
                                return SizedBox(
                                  height: AppDimensions.smallPadding,
                                );
                              }),
                              MessageBodyWidget(message),
                              SizedBox(
                                height: AppDimensions.primaryPadding,
                              ),
                              Builder(builder: (_) {
                                if (message.linkInfo == null) return SizedBox();

                                return Column(
                                  children: <Widget>[
                                    LinkInfoWidget(message),
                                    SizedBox(
                                      height: AppDimensions.primaryPadding,
                                    ),
                                  ],
                                );
                              }),
                              _createTopic(message),
                              Divider(
                                indent: AppDimensions.primaryPadding,
                                height: 1,
                                color: AppColors.dividerGrey,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppDimensions.primaryPadding,
                                    vertical: 15),
                                child: CommentWidget(bodyItem: message),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: BlocBuilder(
                            bloc: _relatedBloc,
                            builder: (_, MessageRelatedState state) {
                              if (state is LoadedMessageRelatedListState) {
                                return _RelatedWidget(
                                  listRelated: state.messageList,
                                );
                              }
                              return SizedBox();
                            }),
                      ),
                      SliverToBoxAdapter(
                        child: _CommentListWidget(
                            message, _commentListBloc, _commentListKey),
                      )
                    ],
                  )),
            ),
          );
        }

        return NormalPage(
          body: PageLoadingWidget(),
          title: NormalTitle('动态详情'),
        );
      },
    );
  }

  Widget _createTopic(Message message) {
    Topic topic = message.topic;

    if (topic == null) return SizedBox();

    return Container(
      color: AppColors.topicBackground,
      padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.primaryPadding,
          vertical: AppDimensions.smallPadding),
      margin: EdgeInsets.only(bottom: AppDimensions.primaryPadding),
      child: Row(
        children: <Widget>[
          AppNetWorkImage(
            src: topic.squarePicture.thumbnailUrl,
            width: 35,
            height: 35,
            borderRadius: BorderRadius.circular(5),
          ),
          SizedBox(
            width: AppDimensions.primaryPadding,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  topic.content,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).primaryTextTheme.subtitle,
                ),
                SizedBox(
                  height: AppDimensions.smallPadding,
                ),
                LayoutBuilder(
                  builder: (context, layout) {
                    return Text(topic.subscribersDescription,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: AppColors.tipsTextColor, fontSize: 11));
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.blue, width: 1),
                borderRadius: BorderRadius.circular(12),
                shape: BoxShape.rectangle),
            child: Center(
              child: Text(
                '加入',
                style: TextStyle(fontSize: 12, color: AppColors.blue),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _RelatedWidget extends StatelessWidget {
  final PageController _pageController = PageController(viewportFraction: 0.9);

  final List<Message> listRelated;

  _RelatedWidget({this.listRelated = const []});

  @override
  Widget build(BuildContext context) {
    if (listRelated.isEmpty) return SizedBox();

    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: AppDimensions.primaryPadding),
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.primaryPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: AppDimensions.primaryPadding,
          ),
          Text(
            '相关推荐',
            style: TextStyle(color: AppColors.primaryTextColor),
          ),
          SizedBox(
            height: AppDimensions.primaryPadding,
          ),
          Divider(
            height: 1,
            color: AppColors.dividerGrey,
          ),
          SizedBox(
            height: 100,
            child: LayoutBuilder(
              builder: (_, layout) {
                return PageView.builder(
                  itemBuilder: (_, index) {
                    Message item = listRelated[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return MessageDetailPage(
                            id: item.id,
                            pageName: 'tab_recommend',
                            type: item.messageType,
                            userRef: item.user?.ref ?? '',
                            topicRef: item.topic?.ref ?? '',
                          );
                        }));
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Transform.translate(
                        offset: Offset(-(layout.maxWidth * 0.1 / 2), 0),
                        child: Row(
                          children: <Widget>[
                            Builder(
                              builder: (_) {
                                String imgUrl = '';

                                if (item.video != null) {
                                  imgUrl = item.video.image.thumbnailUrl;
                                } else if (item.pictures.isNotEmpty) {
                                  imgUrl = item.pictures.first.thumbnailUrl;
                                } else if (item.linkInfo != null) {
                                  imgUrl = item.linkInfo.pictureUrl;
                                } else if (item.user != null) {
                                  imgUrl = item.user.avatarImage.thumbnailUrl;
                                }

                                if (imgUrl.isEmpty) {
                                  return SizedBox();
                                }

                                return Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    AppNetWorkImage(
                                      src: imgUrl,
                                      height: 70,
                                      width: 70,
                                    ),
                                    _createImageType(listRelated[index]),
                                  ],
                                );
                              },
                            ),
                            SizedBox(
                              width: AppDimensions.primaryPadding,
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 70,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: AppDimensions.smallPadding / 2),
                                      child: Text(
                                        item.content,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Builder(builder: (_) {
                                      if (item.topic == null) {
                                        if (item.user != null) {
                                          return Text(
                                            '来自 ${item.user.screenName}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: AppColors.tipsTextColor),
                                          );
                                        }

                                        return SizedBox();
                                      }
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            bottom:
                                                AppDimensions.smallPadding / 2),
                                        child: Row(
                                          children: <Widget>[
                                            Opacity(
                                              child: Image.asset(
                                                'images/ic_personal_tab_my_topic.png',
                                                color: Colors.white,
                                                colorBlendMode: BlendMode.color,
                                                width: 18,
                                                height: 18,
                                              ),
                                              opacity: 0.8,
                                            ),
                                            SizedBox(
                                              width:
                                                  AppDimensions.smallPadding /
                                                      2,
                                            ),
                                            Text(
                                              item.topic.content,
                                              style: TextStyle(
                                                  color:
                                                      AppColors.tipsTextColor,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: AppDimensions.primaryPadding,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: listRelated.length,
                  physics: BouncingScrollPhysics(),
                  controller: _pageController,
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _createImageType(Message message) {
    if (message.video != null) {
      /// video
      return Image.asset('images/ic_personaltab_activity_video_play.png');
    } else if (message.pictures.isNotEmpty &&
        message.pictures.first.format == 'gif') {
      return Image.asset('images/ic_personaltab_activity_gif.png');
    }

    return SizedBox();
  }
}

/// 评论列表
class _CommentListWidget extends StatefulWidget {
  final Message message;
  final CommentListBloc bloc;

  _CommentListWidget(this.message, this.bloc, Key key) : super(key: key);

  @override
  __CommentListWidgetState createState() => __CommentListWidgetState();
}

class __CommentListWidgetState extends State<_CommentListWidget>
    with AfterLayoutMixin<_CommentListWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: widget.bloc,
      builder: (_, CommentListState state) {
        if (state is LoadedCommentListState) {
          return Column(
            children: <Widget>[
              Builder(builder: (_) {
                if (state.hotCommentList.isEmpty) {
                  return SizedBox();
                }

                /// 热门评论
                return Padding(
                  padding:
                      EdgeInsets.only(bottom: AppDimensions.primaryPadding),
                  child: CommentListWidget('热门评论', state.hotCommentList),
                );
              }),
              Builder(builder: (_) {
                if (state.commentList.isEmpty)
                  return Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 50),
                    child: Center(
                      child: Text(
                        '目前还没有评论',
                        style: TextStyle(
                            fontSize: 14, color: AppColors.tipsTextColor),
                      ),
                    ),
                  );

                return CommentListWidget('最新评论', state.commentList);
              }),
            ],
          );
        }

        return PageLoadingWidget();
      },
    );
  }

  refreshData({bool loadMore = false}) {
    widget.bloc.dispatch(FetchCommentListEvent(widget.message.id,
        targetType: widget.message.type, loadMore: loadMore));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    refreshData();
  }
}
