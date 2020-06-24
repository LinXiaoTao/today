import 'package:today/ui/ui_base.dart';
import 'package:today/ui/page/video_player.dart';
import 'package:today/widget/message.dart';
import 'package:intl/intl.dart';

final DateFormat _dateFormat = DateFormat('MM/dd HH:mm');

class VideoListPage extends StatefulWidget {
  final Message message;

  VideoListPage(this.message);

  @override
  _VideoListPageState createState() => _VideoListPageState();
}

class _VideoListPageState extends State<VideoListPage>
    with AfterLayoutMixin<VideoListPage> {
  final VideoListBloc _videoListBloc = VideoListBloc();
  bool _firstLaunch = true;
  GlobalKey<VideoPlayerWidgetState> _curPlayerKey;
  final PageController _pageController = PageController();
  int _prePage = 0;

  @override
  void dispose() {
    _videoListBloc?.close();
    super.dispose();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _videoListBloc.add(FetchVideoListEvent(widget.message));
  }

  _autoPlay() {
    if (_curPlayerKey.currentState == null) {
      debugPrint('null!!!!!');
    }
    _curPlayerKey.currentState?.play();
  }

  @override
  Widget build(BuildContext context) {
    return NormalPage(
        needAppBar: false,
        backgroundColor: Colors.black,
        body: BlocBuilder(
            bloc: _videoListBloc,
            builder: (_, VideoListState state) {
              if (state is LoadedVideoListState) {
                return NotificationListener<ScrollEndNotification>(
                  onNotification: (notification) {
                    /// 滚动结束
                    if (_prePage == _pageController.page) {
                      return;
                    }
                    _prePage = _pageController.page.toInt();

                    /// todo 暂时没想到其他更好的方法
                    Future.delayed(Duration(milliseconds: 300)).then((_) {
                      _autoPlay();
                    });
                  },
                  child: PageView.builder(
                    physics: BouncingScrollPhysics(),
                    controller: _pageController,
                    itemBuilder: (_, index) {
                      final GlobalKey<VideoPlayerWidgetState> _playerKey =
                          GlobalKey();
                      _curPlayerKey = _playerKey;
                      Message item = state.items[index];
                      bool autoPlay = _firstLaunch;
                      _firstLaunch = false;
                      return Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          VideoPlayerWidget(
                            id: state.items[index].id,
                            key: _playerKey,
                            autoPlay: autoPlay,
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: _TopWidget(item),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: _BottomWidget(
                              item,
                              _playerKey,
                            ),
                          ),
                          Builder(builder: (_) {
                            return StreamBuilder<VideoPlayerValue>(
                              stream: _playerKey.currentState.loadMediaStream,
                              builder: (_, snapshot) {
                                if (snapshot.hasData) {
                                  final duration =
                                      snapshot.data.duration ?? Duration();
                                  final position =
                                      snapshot.data.position ?? Duration();

                                  if (position.inSeconds >=
                                      duration.inSeconds) {
                                    return GestureDetector(
                                      onTap: () {
                                        _playerKey.currentState.play();
                                      },
                                      child: Image.asset(
                                          'images/ic_mediaplayer_videoplayer_replay.png'),
                                    );
                                  }
                                }

                                return SizedBox();
                              },
                            );
                          }),
                        ],
                      );
                    },
                    itemCount: state.items.length,
                    scrollDirection: Axis.vertical,
                  ),
                );
              }

              return Center(child: PageLoadingWidget());
            }));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}

class _TopWidget extends StatelessWidget {
  final Message item;

  const _TopWidget(
    this.item, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.black45, Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: SizedBox(
          height: 60,
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.primaryPadding * 2),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Builder(builder: (_) {
                  if (item.user == null) return SizedBox();

                  return Row(
                    children: <Widget>[
                      AvatarWidget(item.user),
                      SizedBox(
                        width: AppDimensions.smallPadding,
                      ),
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ScreenNameWidget(
                                user: item.user,
                                textColor: Colors.white,
                                fontSize: 13,
                              ),
                              SizedBox(
                                height: AppDimensions.smallPadding,
                              ),
                              Text(
                                _dateFormat.format(
                                    DateTime.parse(item.createdAt).toLocal()),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.white54, fontSize: 12),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomWidget extends StatefulWidget {
  final Message item;
  final GlobalKey<VideoPlayerWidgetState> playerKey;

  _BottomWidget(this.item, this.playerKey);

  @override
  State<StatefulWidget> createState() {
    return _BottomState();
  }
}

class _BottomState extends State<_BottomWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.black45, Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.primaryPadding * 1.5),
            child: Row(
              children: <Widget>[
                StreamBuilder<VideoPlayerValue>(
                  stream: widget.playerKey.currentState.loadMediaStream,
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      final videoData = snapshot.data;
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          if (videoData.isPlaying) {
                            widget.playerKey.currentState.pause();
                          } else {
                            widget.playerKey.currentState.play();
                          }
                        },
                        child: Image.asset((videoData.isPlaying
                            ? 'images/ic_mediaplayer_videoplayer_pause.png'
                            : 'images/ic_mediaplayer_videoplayer_play.png')),
                      );
                    }
                    return SizedBox();
                  },
                ),
                Expanded(
                  child: StreamBuilder<VideoPlayerValue>(
                    stream: widget.playerKey.currentState.loadMediaStream,
                    builder: (_, snapshot) {
                      int cur = 0;
                      int max = 0;
                      if (snapshot.hasData) {
                        final duration = snapshot.data.duration ?? Duration();
                        final position = snapshot.data.position ?? Duration();

                        cur = position.inSeconds;
                        max = duration.inSeconds;
                      }
                      return Slider.adaptive(
                        value: cur.toDouble(),
                        max: max.toDouble(),
                        activeColor: AppColors.accentColor,
                        inactiveColor: Colors.white,
                        onChanged: (double value) {
                          widget.playerKey.currentState
                              .seekTo(Duration(seconds: value.toInt()));
                        },
                      );
                    },
                  ),
                ),
                StreamBuilder(
                    stream: widget.playerKey.currentState.loadMediaStream,
                    builder: (_, snapshot) {
                      Duration duration = Duration();
                      Duration position = Duration();
                      if (snapshot.hasData) {
                        final videoData = snapshot.data;
                        duration = videoData.duration ?? Duration();
                        position = videoData.position ?? Duration();
                      }

                      return Text(
                        '${_formatDuration(position)}/${_formatDuration(duration)}',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      );
                    }),
                SizedBox(
                  width: AppDimensions.primaryPadding,
                ),
                Image.asset('images/ic_mediaplayer_videoplayer_landscape.png'),
              ],
            ),
          ),
          SizedBox(
            height: AppDimensions.primaryPadding * 2,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.primaryPadding * 1.5),
            child: Text(
              widget.item.content,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(
            height: AppDimensions.primaryPadding * 2.5,
          ),
          SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Image.asset('images/ic_messages_like_unselected.png'),
                    SizedBox(
                      height: AppDimensions.smallPadding,
                    ),
                    Text(
                      '${widget.item.likeCount}',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Image.asset('images/ic_messages_comment.png'),
                    SizedBox(
                      height: AppDimensions.smallPadding,
                    ),
                    Text(
                      '${widget.item.commentCount}',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Image.asset('images/ic_messages_collect_unselected.png'),
                    SizedBox(
                      height: AppDimensions.smallPadding,
                    ),
                    Text(
                      '收藏',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Image.asset('images/ic_messages_share.png'),
                    SizedBox(
                      height: AppDimensions.smallPadding,
                    ),
                    Text(
                      '${widget.item.shareCount}',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final _numberFormat = NumberFormat('00');

  _formatDuration(Duration duration) {
    return '${_numberFormat.format(duration.inMinutes)}:${_numberFormat.format(duration.inSeconds - duration.inMinutes * Duration.secondsPerMinute)}';
  }
}
