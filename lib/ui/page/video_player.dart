import 'package:today/ui/ui_base.dart';
import 'package:video_player/video_player.dart';
export 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String id;
  final bool autoPlay;

  VideoPlayerWidget({@required this.id, Key key, this.autoPlay = false})
      : super(key: key);

  @override
  VideoPlayerWidgetState createState() => VideoPlayerWidgetState();
}

class VideoPlayerWidgetState extends State<VideoPlayerWidget>
    with AfterLayoutMixin<VideoPlayerWidget> {
  VideoPlayerController _controller;
  MediaBloc _mediaBloc = MediaBloc();

  final StreamController<VideoPlayerValue> _loadMediaStreamController =
      StreamController();

  Stream<VideoPlayerValue> _loadMediaStream;

  Stream<VideoPlayerValue> get loadMediaStream {
    if (_loadMediaStream == null) {
      _loadMediaStream = _loadMediaStreamController.stream.asBroadcastStream();
    }
    return _loadMediaStream;
  }

  bool playFlag = false;

  Future<void> play() async {
    if (_controller != null &&
        _controller.value != null &&
        _controller.value.initialized) {
      /// 已经初始化完
      if (_controller.value.position.inSeconds >=
          _controller.value.duration.inSeconds) {
        /// 已经播放完了
        await seekTo(Duration.zero);
      }
      return _controller?.play();
    } else {
      playFlag = true;
      return Future.value();
    }
  }

  Future<void> pause() {
    return _controller?.pause();
  }

  Future<void> seekTo(Duration moment) {
    _controller.value = _controller.value.copyWith(position: moment);
    if (moment.inSeconds >= _controller.value.duration.inSeconds) {
      pause();
    }
    return _controller?.seekTo(moment);
  }

  Future<void> setVolume(double volume) {
    return _controller?.setVolume(volume);
  }

  Future<void> setLoop(bool looping) {
    return _controller?.setLooping(looping);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _mediaBloc?.dispose();
    _loadMediaStreamController?.close();
    _controller?.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    pause();
    super.deactivate();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _mediaBloc.dispatch(FetchMediaEvent(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _mediaBloc,
        builder: (_, state) {
          if (state is LoadedMediaState) {
            _controller = VideoPlayerController.network(state.url);
            _controller.addListener(() {
              _loadMediaStreamController.sink.add(_controller.value);
            });
            _controller.initialize().then((_) {
              if (widget.autoPlay || playFlag) {
                play();
              }
            });

            return StreamBuilder<VideoPlayerValue>(
              builder: (_, snapshot) {
                if (snapshot.hasData && snapshot.data.initialized) {
                  return Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        ),
                        Builder(builder: (_) {
                          if (snapshot.data.isBuffering) {
                            return SpinKitWave(
                              size: 25,
                              color: Colors.white54,
                            );
                          }

                          return SizedBox();
                        }),
                      ],
                    ),
                  );
                }

                return SpinKitWave(
                  size: 25,
                  color: Colors.white54,
                );
              },
              stream: loadMediaStream,
            );
          }

          return SpinKitWave(
            size: 25,
            color: Colors.white54,
          );
        });
  }
}
