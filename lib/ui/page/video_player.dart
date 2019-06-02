import 'package:today/ui/ui_base.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  final String id;

  VideoPlayerPage({@required this.id});

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage>
    with AfterLayoutMixin<VideoPlayerPage> {
  VideoPlayerController _controller;
  MediaBloc _mediaBloc = MediaBloc();
  Stream<bool> _loadMediaStream;

  @override
  void dispose() {
    _controller?.dispose();
    _mediaBloc?.dispose();
    super.dispose();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _mediaBloc.dispatch(FetchMediaEvent(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return NormalPage(
      backgroundColor: Colors.black,
      body: BlocBuilder(
          bloc: _mediaBloc,
          builder: (_, state) {
            if (state is LoadedMediaState) {
              _controller = VideoPlayerController.network(state.url);
              _loadMediaStream =
                  Stream.fromFuture(_controller.initialize()).map((_) {
                return true;
              });

              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Center(
                  child: StreamBuilder(
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                        _controller.play();
                        return AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        );
                      }

                      return SpinKitWave(
                        size: 25,
                        color: Colors.white54,
                      );
                    },
                    stream: _loadMediaStream,
                  ),
                ),
              );
            }

            return SpinKitWave(
              size: 25,
              color: Colors.white54,
            );
          }),
      needAppBar: false,
    );
  }
}
