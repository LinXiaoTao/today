import 'package:today/ui/ui_base.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NormalPage(
      needAppBar: false,
      body: _HomeBody(),
    );
  }
}

class _HomeBody extends StatefulWidget {
  @override
  __HomeBodyState createState() => __HomeBodyState();
}

class __HomeBodyState extends State<_HomeBody>
    with AfterLayoutMixin<_HomeBody> {
  UserInfo _userInfo;
  final List<RecommendItem> _recommendList = [];
  final List<RecommendHeadItem> _recommendHeadList = [];
  StreamSubscription _subscription;
  LoadMoreKey _loadMoreKey;

  @override
  void initState() {
    super.initState();

    _subscription = Global.eventBus.on<RefreshTokenEvent>().listen((event) {
      afterFirstLayout(context);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    if (_userInfo == null) return Container();

    List<Widget> headWidgetList = _recommendHeadList.map<Widget>((headItem) {
      return Container(
        margin: EdgeInsets.only(
            right: 11, left: (_recommendHeadList[0] == headItem ? 11 : 0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: NetworkImage(headItem.picUrl))),
            ),
            SizedBox(
              height: 11,
            ),
            SizedBox(
              width: 75,
              child: Text(
                headItem.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      );
    }).toList();

    debugPrint("top: ${MediaQuery.of(context).padding.top}");

    return Column(
      children: <Widget>[
        Container(
          color: Color(0xffffe411),
          height: MediaQuery.of(context).padding.top,
        ),
        Expanded(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverPersistentHeader(
                  floating: true,
                  delegate: _SliverSearchDelegate(
                      maxHeight: 60,
                      child: Container(
                        color: Color(0xffffe411),
                        height: 60,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: TextField(
                                      decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Search",
                                    prefixIcon: Image.asset(
                                        "images/ic_navbar_search.png"),
                                  )),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Image.asset("images/ic_navbar_scan.png"),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                      ))),
              SliverToBoxAdapter(
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      height: 150,
                      child: ListView(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        children: headWidgetList,
                      ),
                    ),
                    SizedBox(
                      height: 11,
                    ),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  RecommendItem item = _recommendList[index];
                  RecommendBodyItem bodyItem = item.item;

                  return Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        (bodyItem.content == null || bodyItem.content.isEmpty
                            ? SizedBox(
                                width: 0,
                                height: 0,
                              )
                            : Text(bodyItem.content)),
                        _createContentWidget(bodyItem),
                      ],
                    ),
                  );
                }, childCount: _recommendList.length),
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  void afterFirstLayout(BuildContext context) async {
    _userInfo = await ApiRequest.profile();
    RecommendFeed recommendData = await ApiRequest.recommendFeedList();
    if (recommendData.data.isNotEmpty &&
        recommendData.data[0].type == "HEADLINE_RECOMMENDATION") {
      _recommendHeadList.addAll(recommendData.data[0].items);
      recommendData.data.removeAt(0);
    }
    _recommendList.addAll(recommendData.data);
    Toast.show(recommendData.toastMessage, context,
        duration: 5, gravity: Toast.TOP);
    setState(() {});
  }

  Widget _createContentWidget(RecommendBodyItem bodyItem) {
    if (bodyItem.video != null) {
      /// video
      /// fix width
      var video = bodyItem.video;
      return Container(
        margin: EdgeInsets.only(top: 5),
        child: LayoutBuilder(builder: (context, constraints) {
          debugPrint(
              "maxWidth = ${constraints.maxWidth}; maxHeight = ${constraints.maxHeight}");
          return SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxWidth.toDouble() / 2,
            child: Stack(
              children: <Widget>[
                AppNetWorkImage(
                  src: video.image.thumbnailUrl,
                  fit: BoxFit.fitWidth,
                  width: constraints.maxWidth,
                  alignment: Alignment.centerLeft,
                ),
                Align(
                  child:
                      Image.asset("images/ic_mediaplayer_videoplayer_play.png"),
                )
              ],
            ),
          );
        }),
      );
    } else if (bodyItem.pictures.isNotEmpty) {
      /// 图片

      List<Picture> pictures = bodyItem.pictures;

      if (pictures.length == 1) {
        /// 单个

        if ((pictures.single.width ?? 0) <= 0 ||
            (pictures.single.height ?? 0) <= 0) {
          return SizedBox(
            width: 0,
            height: 0,
          );
        }

        double width = pictures.single.width.toDouble();
        double height = pictures.single.height.toDouble();

        double aspectRatio = width / height;

        debugPrint("aspectRatio = $aspectRatio");

        return Column(
          children: <Widget>[
            SizedBox(
              height: 5,
            ),
            LayoutBuilder(
              builder: (context, layout) {
                while (width > layout.maxWidth || height > 300) {
                  width /= 2;
                  height /= 2;
                }

                debugPrint("width = $width; height = $height");

                return AppNetWorkImage(
                  src: pictures.single.thumbnailUrl,
                  width: width,
                  height: height,
                  alignment: Alignment.centerLeft,
                );
              },
            ),
          ],
        );
      } else {
        /// 九宫格

        int axisCount = 3;
        if (pictures.length == 4) {
          axisCount = 2;
        }
        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: axisCount,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5),
          itemBuilder: (context, index) {
            return LayoutBuilder(
              builder: (context, layout) {
                return AppNetWorkImage(
                  src: pictures[index].thumbnailUrl,
                  width: layout.maxWidth,
                  height: layout.maxWidth,
                );
              },
            );
          },
          itemCount: pictures.length,
        );
      }
    } else {
      /// 纯文字
      return SizedBox(
        width: 0,
        height: 0,
      );
    }
  }
}

class _SliverSearchDelegate extends SliverPersistentHeaderDelegate {
  final double maxHeight;
  final double minHeight;
  final Widget child;

  _SliverSearchDelegate(
      {@required this.maxHeight, @required this.child, this.minHeight = 0});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate.maxExtent != maxHeight ||
        oldDelegate.minExtent != minHeight;
  }
}
