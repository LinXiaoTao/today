import 'package:today/ui/ui_base.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:photo_view/photo_view.dart';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';

class PictureDetailPage extends StatefulWidget {
  final List<Picture> pictures;
  final int initIndex;

  PictureDetailPage(this.pictures, {this.initIndex = 0});

  @override
  _PictureDetailPageState createState() => _PictureDetailPageState();
}

class _PictureDetailPageState extends State<PictureDetailPage> {
  PageController _pageController;

  StreamController<int> _indexStreamController = StreamController(sync: true);

  @override
  void dispose() {
    _indexStreamController.close();
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.initIndex);
    debugPrint('initIndex = ${widget.initIndex}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NormalPage(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            itemCount: widget.pictures.length,
            builder: (context, index) {
              Picture picture = widget.pictures[index];
              return PhotoViewGalleryPageOptions(
                imageProvider: CachedNetworkImageProvider(picture.picUrl,
                    headers: {
                      key_access_token: LoginState.accessToken,
                      key_device_id: LoginState.deviceId
                    }),
                heroTag: picture.picUrl,
                minScale: PhotoViewComputedScale.contained,
                initialScale: PhotoViewComputedScale.contained,
                maxScale: 2.0,
              );
            },
            loadingChild: SpinKitFadingCircle(
              color: Colors.white,
            ),
            pageController: _pageController,
            backgroundDecoration: BoxDecoration(color: Colors.black),
            onPageChanged: (index) {
              if (widget.pictures.length == 1) return;
              _indexStreamController.sink.add(index);
            },
          ),
          Builder(builder: (context) {
            if (widget.pictures.length == 1) {
              return SizedBox();
            }
            return Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: StreamBuilder(
                  stream: _indexStreamController.stream,
                  initialData: widget.initIndex,
                  builder: (context, snapshot) {
                    return Text(
                      '${snapshot.data + 1}/${widget.pictures.length}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
            );
          })
        ],
      ),
      needAppBar: false,
    );
  }
}
