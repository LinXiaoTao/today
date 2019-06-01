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

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _requestInteractive(widget.id);
  }

  _requestInteractive(String id,
      {String type = 'ORIGINAL_POST', String trigger = 'user'}) async {
    Map result = await ApiRequest.mediaMeta(
        {'id': id, 'type': type, 'trigger': trigger});

    _controller = VideoPlayerController.network(result['url'])
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _controller.play();
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return NormalPage(
      backgroundColor: Colors.black,
      body: Builder(builder: (_) {
        if (_controller == null || !_controller.value.initialized) {
          return SpinKitWave(
            size: 25,
            color: Colors.white54,
          );
        }
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Center(
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
          ),
        );
      }),
      needAppBar: false,
    );
  }
}
