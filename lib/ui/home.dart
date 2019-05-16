import 'package:flutter/gestures.dart';
import 'package:today/ui/ui_base.dart';
import 'package:today/ui/debug.dart';

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
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return DebugPage();
                                  }));
                                },
                                child:
                                    Image.asset("images/ic_navbar_scan.png")),
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
                  Topic topic = bodyItem.topic;

                  Comment topComment = bodyItem.topComment;

                  List<UserInfo> involvedUsers = topic.involvedUsers.users;

                  List<Widget> involvedUsersWidget = [];

                  for (UserInfo user in involvedUsers) {
                    involvedUsersWidget.add(Positioned(
                        right: involvedUsers.indexOf(user) * 30.0,
                        child: AppNetWorkImage(
                          src: user.avatarImage.thumbnailUrl,
                          width: 36,
                          height: 36,
                          borderRadius: BorderRadius.circular(18),
                        )));
                  }

                  return Column(
                    children: <Widget>[
                      Container(
                        height: 70,
                        alignment: Alignment.center,
                        color: Colors.grey[50],
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: <Widget>[
                            AppNetWorkImage(
                              src: topic.squarePicture.thumbnailUrl,
                              width: 50,
                              height: 50,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  topic.content,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .subtitle,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(topic.subscribersDescription,
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 10)),
                              ],
                            ),
                            Spacer(),
                            LimitedBox(
                                maxWidth: 100,
                                child: Stack(
                                  children: involvedUsersWidget,
                                  alignment: Alignment.center,
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Image.asset('images/ic_common_arrow_right.png')
                          ],
                        ),
                      ),
                      LayoutBuilder(
                        builder: (context, layout) {
                          return Container(
                            width: layout.maxWidth,
                            color: Colors.white,
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                (bodyItem.content == null ||
                                        bodyItem.content.trim().isEmpty
                                    ? SizedBox()
                                    : Builder(builder: (context) {
                                        TextSpan content;
                                        if (bodyItem.urlsInText != null &&
                                            bodyItem.urlsInText.isNotEmpty) {
                                          List<TextSpan> child = [];

                                          List<int> indexList = [];

                                          for (UrlsInText text
                                              in bodyItem.urlsInText) {
                                            indexList.add(bodyItem.content
                                                .indexOf(RegExp(text.title)));
                                          }

                                          debugPrint("indexs = $indexList");

                                          int cur = 0;
                                          int indexPos = 0;
                                          while (indexPos < indexList.length) {
                                            if (indexList[indexPos] > cur) {
                                              child.add(TextSpan(
                                                  text: bodyItem.content
                                                      .substring(
                                                          cur,
                                                          indexList[
                                                              indexPos])));
                                              cur = indexList[indexPos];
                                            } else {
                                              int startIndex =
                                                  indexList[indexPos];
                                              int endIndex = startIndex +
                                                  bodyItem.urlsInText[indexPos]
                                                      .title.length;

                                              child.add(TextSpan(
                                                  text: bodyItem.content
                                                      .substring(
                                                          startIndex, endIndex),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .body1
                                                      .merge(TextStyle(
                                                          color:
                                                              Colors.blue))));
                                              cur = endIndex;
                                              indexPos++;
                                            }
                                          }

                                          if (cur < bodyItem.content.length) {
                                            child.add(TextSpan(
                                                text: bodyItem.content
                                                    .substring(
                                                        cur,
                                                        bodyItem
                                                            .content.length)));
                                          }

                                          content = TextSpan(
                                              children: child,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .body1);
                                        } else {
                                          content = TextSpan(
                                              text: bodyItem.content,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .body1);
                                        }

                                        return Text.rich(content);
                                      })),
                                _createContentWidget(bodyItem),
                              ],
                            ),
                          );
                        },
                      ),
                      (topComment == null
                          ? SizedBox(
                              height: 10,
                            )
                          : Container(
                              color: Colors.grey[50],
                              margin: EdgeInsets.only(bottom: 10),
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Image.asset(
                                          'images/ic_comment_popular.png'),
                                      Text(
                                        "${topComment.likeCount} 赞",
                                        style: TextStyle(
                                            color: AppColors.normalTextColor,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Builder(builder: (context) {
                                    TapGestureRecognizer tap =
                                        TapGestureRecognizer();
                                    tap.onTap = () {
                                      Toast.show(
                                          topComment.user.screenName, context);
                                    };
                                    TextSpan child = TextSpan(
                                        text: '：${topComment.content}',
                                        style: TextStyle(
                                            color: AppColors.primaryTextColor));

                                    TextSpan content = TextSpan(
                                        text: topComment.user.screenName,
                                        style: TextStyle(color: Colors.blue),
                                        recognizer: tap,
                                        children: [child]);

                                    return Text.rich(
                                      content,
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    );
                                  }),
                                  LayoutBuilder(builder: (context, layout) {
                                    if (topComment.pictures == null ||
                                        topComment.pictures.isEmpty)
                                      return SizedBox();

                                    debugPrint(
                                        "topComent picture: ${topComment.pictures}");

                                    double width = topComment
                                        .pictures.first.width
                                        .toDouble();
                                    double height = topComment
                                        .pictures.first.height
                                        .toDouble();

                                    while (width > layout.maxWidth ||
                                        height > 200) {
                                      width /= 2;
                                      height /= 2;
                                    }

                                    return Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: AppNetWorkImage(
                                        src: topComment
                                            .pictures.first.thumbnailUrl,
                                        width: width,
                                        height: height,
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ))
                    ],
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
              "${bodyItem.content}: maxWidth = ${constraints.maxWidth}; maxHeight = ${constraints.maxHeight}");
          debugPrint("vidoe img: ${video.image.thumbnailUrl}");
          return SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxWidth.toDouble() / 2,
            child: Stack(
              children: <Widget>[
                AppNetWorkImage(
                  src: '${video.image.thumbnailUrl}.jpg',
                  fit: BoxFit.fitWidth,
                  width: constraints.maxWidth,
                  alignment: Alignment.centerLeft,
                  borderRadius: BorderRadius.circular(5),
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

                debugPrint(
                    "${bodyItem.content}: width = $width; height = $height");

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
          padding: EdgeInsets.only(
              top:
                  ((bodyItem.content == null || bodyItem.content.trim().isEmpty)
                      ? 0
                      : 10)),
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
