import 'package:today/ui/ui_base.dart';
import 'package:today/data/model/recommendfeed.dart';
import 'package:today/ui/page/picture_detail.dart';

class MessageItem extends StatelessWidget {
  final RecommendItem item;

  MessageItem(this.item);

  @override
  Widget build(BuildContext context) {
    RecommendBodyItem bodyItem = item.item;
    Topic topic = bodyItem.topic;

    Comment topComment = bodyItem.topComment;

    List<UserInfo> involvedUsers = topic.involvedUsers.users.reversed.toList();

    List<Widget> involvedUsersWidget = [];

    for (UserInfo user in involvedUsers) {
      involvedUsersWidget.add(Positioned(
          right: involvedUsers.indexOf(user) * 20.0,
          child: AppNetWorkImage(
            src: user.avatarImage.thumbnailUrl,
            width: 30,
            height: 30,
            borderRadius: BorderRadius.circular(13),
          )));
    }

    return Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                height: 70,
                alignment: Alignment.center,
                color: AppColors.topicBackground,
                padding: EdgeInsets.all(AppDimensions.primaryPadding),
                child: Row(
                  children: <Widget>[
                    AppNetWorkImage(
                      src: topic.squarePicture.thumbnailUrl,
                      width: 40,
                      height: 40,
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
                                      color: AppColors.green, fontSize: 11));
                            },
                          ),
                        ],
                      ),
                    ),
                    LimitedBox(
                        maxWidth: 70,
                        child: Stack(
                          children: involvedUsersWidget,
                          alignment: Alignment.center,
                        )),
                    SizedBox(
                      width: AppDimensions.primaryPadding,
                    ),
                    Image.asset('images/ic_common_arrow_right.png')
                  ],
                ),
              ),
              LayoutBuilder(
                builder: (context, layout) {
                  return Container(
                    width: layout.maxWidth,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _RichTextWidget(bodyItem),
                        _createContentWidget(bodyItem, context),
                        SizedBox(
                          height: AppDimensions.primaryPadding,
                        ),
                        Builder(builder: (context) {
                          UserInfo user = bodyItem.user;

                          if (user == null) return SizedBox();

                          return Row(
                            children: <Widget>[
                              AppNetWorkImage(
                                src: user.avatarImage.thumbnailUrl,
                                width: 30,
                                height: 30,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              SizedBox(
                                width: AppDimensions.smallPadding,
                              ),
                              Text(
                                user.screenName,
                                style: TextStyle(
                                    color: AppColors.primaryTextColor,
                                    fontSize: 12),
                              ),
                              SizedBox(
                                width: AppDimensions.smallPadding,
                              ),
                              Builder(builder: (context) {
                                debugPrint(
                                    "trailingIcons = ${user.trailingIcons}");

                                if (user.trailingIcons.isEmpty) {
                                  return SizedBox();
                                }

                                List<Widget> images = [];

                                for (TrailingIcons icon in user.trailingIcons) {
                                  images.add(AppNetWorkImage(
                                    src: icon.picUrl,
                                    width: 12,
                                    height: 12,
                                    borderRadius: BorderRadius.circular(0),
                                  ));
                                  images.add(SizedBox(
                                    width: 1,
                                  ));
                                }

                                return Row(
                                  children: images,
                                );
                              }),
                              (user.trailingIcons.isEmpty
                                  ? SizedBox()
                                  : SizedBox(
                                      width: AppDimensions.smallPadding,
                                    )),
                              Text(
                                '发布',
                                style: TextStyle(
                                    color: AppColors.tipsTextColor,
                                    fontSize: 12),
                              ),
                              Spacer(),
                              Builder(builder: (context) {
                                if (bodyItem.poi == null ||
                                    bodyItem.poi.name == null)
                                  return SizedBox();

                                return Text(
                                  bodyItem.poi.name,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.tipsTextColor),
                                );
                              })
                            ],
                          );
                        }),
                      ],
                    ),
                  );
                },
              ),
              (topComment == null
                  ? SizedBox()
                  : Container(
                      color: Colors.grey[50],
                      margin: EdgeInsets.only(
                          left: AppDimensions.primaryPadding,
                          right: AppDimensions.primaryPadding,
                          bottom: AppDimensions.primaryPadding),
                      padding: EdgeInsets.all(AppDimensions.primaryPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Image.asset('images/ic_comment_popular.png'),
                              Text(
                                "${topComment.likeCount} 赞",
                                style: TextStyle(
                                    color: AppColors.normalTextColor,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: AppDimensions.smallPadding,
                          ),
                          Builder(builder: (context) {
                            TapGestureRecognizer tap = TapGestureRecognizer();
                            tap.onTap = () {
                              Fluttertoast.showToast(
                                  msg: topComment.user.screenName);
                            };
                            TextSpan child = TextSpan(
                                text: '：${topComment.content}',
                                style: TextStyle(
                                    color: AppColors.primaryTextColor));

                            TextSpan content = TextSpan(
                                text: topComment.user.screenName,
                                style: TextStyle(color: AppColors.blue),
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
                            if (topComment.pictures.isEmpty) return SizedBox();

                            debugPrint(
                                "topComent picture: ${topComment.pictures}");

                            double width =
                                topComment.pictures.first.width.toDouble();
                            double height =
                                topComment.pictures.first.height.toDouble();
                            double maxWidth = MediaQuery.of(context).size.width;
                            Map measure = ImageUtil.measureImageSize(
                              srcSizes: {'w': width, 'h': height},
                              maxSizes: {
                                'w': maxWidth * 2 / 3,
                                'h': maxWidth / 2
                              },
                            );

                            return Container(
                              margin: EdgeInsets.only(
                                  top: AppDimensions.primaryPadding),
                              child: Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  Hero(
                                    tag: topComment.pictures.first.picUrl,
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return PictureDetailPage(
                                                topComment.pictures);
                                          }));
                                        },
                                        child: AppNetWorkImage(
                                          src: topComment
                                              .pictures.first.thumbnailUrl,
                                          width: measure['w'],
                                          height: measure['h'],
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Builder(builder: (_) {
                                    return SizedBox(
                                      width: measure['w'],
                                      height: measure['h'],
                                      child: _createImageType(
                                          topComment.pictures.first),
                                    );
                                  }),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    )),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.primaryPadding),
                child: Divider(
                  height: 1,
                  color: AppColors.dividerGrey,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.primaryPadding, vertical: 15),
                child: Row(
                  children: <Widget>[
                    Image.asset('images/ic_messages_like_unselected.png'),
                    SizedBox(
                      width: 4,
                    ),
                    Text(bodyItem.likeCount.toString(),
                        style: TextStyle(
                            fontSize: 12, color: AppColors.tipsTextColor)),
                    SizedBox(
                      width: 80,
                    ),
                    Image.asset('images/ic_messages_comment.png'),
                    SizedBox(
                      width: 4,
                    ),
                    Text(bodyItem.commentCount.toString(),
                        style: TextStyle(
                            fontSize: 12, color: AppColors.tipsTextColor)),
                    SizedBox(
                      width: 80,
                    ),
                    Image.asset('images/ic_messages_share.png'),
                    SizedBox(
                      width: 4,
                    ),
                    Text(bodyItem.shareCount.toString(),
                        style: TextStyle(
                            fontSize: 12, color: AppColors.tipsTextColor)),
                    Spacer(),
                    Image.asset('images/ic_messages_more.png'),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: AppDimensions.primaryPadding,
        )
      ],
    );
  }

  Widget _createContentWidget(
      RecommendBodyItem bodyItem, BuildContext context) {
    if (bodyItem.video != null) {
      /// video
      /// fix width
      var video = bodyItem.video;
      return Container(
        margin: EdgeInsets.only(top: AppDimensions.smallPadding),
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

        if (pictures.single.width <= 0 || pictures.single.height <= 0) {
          return SizedBox(
            width: 0,
            height: 0,
          );
        }

        double width = pictures.single.width.toDouble();
        double height = pictures.single.height.toDouble();
        double maxWidth = MediaQuery.of(context).size.width;
        Map measure = ImageUtil.measureImageSize(
          srcSizes: {'w': width, 'h': height},
          maxSizes: {'w': maxWidth * 2 / 3, 'h': maxWidth / 2},
        );

        return Column(
          children: <Widget>[
            SizedBox(
              height: AppDimensions.smallPadding,
            ),
            LayoutBuilder(
              builder: (context, layout) {
                return Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Hero(
                      tag: pictures.single.picUrl,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return PictureDetailPage(pictures);
                            }));
                          },
                          child: AppNetWorkImage(
                            src: pictures.single.thumbnailUrl,
                            width: measure['w'],
                            height: measure['h'],
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                        width: measure['w'],
                        height: measure['h'],
                        child: _createImageType(pictures.single)),
                  ],
                );
              },
            ),
          ],
        );
      } else {
        /// 九宫格

        int axisCount = 3;
        return GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.only(
              top: (bodyItem.content.trim().isEmpty
                  ? 0
                  : AppDimensions.primaryPadding)),
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: axisCount,
              mainAxisSpacing: AppDimensions.smallPadding,
              crossAxisSpacing: AppDimensions.smallPadding),
          itemBuilder: (context, index) {
            var picture = pictures[index];
            return LayoutBuilder(
              builder: (context, layout) {
                return Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Hero(
                      tag: picture.picUrl,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return PictureDetailPage(
                                pictures,
                                initIndex: index,
                              );
                            }));
                          },
                          child: AppNetWorkImage(
                            src: picture.thumbnailUrl,
                            width: layout.maxWidth,
                            height: layout.maxWidth,
                          ),
                        ),
                      ),
                    ),
                    Builder(builder: (_) {
                      return _createImageType(picture);
                    }),
                  ],
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

  Widget _createImageType(Picture picture) {
    if (picture.format == 'gif') {
      /// gif
      return Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.smallPadding),
          child: Image.asset('images/ic_messages_pictype_gif.png'),
        ),
      );
    } else if (picture.height > picture.width * 3) {
      /// long
      return Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.smallPadding),
          child: Image.asset('images/ic_messages_pictype_long_pic.png'),
        ),
      );
    } else {
      return SizedBox();
    }
  }
}

class _RichTextWidget extends StatelessWidget {
  final RecommendBodyItem bodyItem;

  _RichTextWidget(this.bodyItem);

  _measureText() {}

  @override
  Widget build(BuildContext context) {
    return (bodyItem.content.trim().isEmpty
        ? SizedBox()
        : Padding(
            padding: EdgeInsets.only(bottom: AppDimensions.primaryPadding),
            child: LayoutBuilder(builder: (context, layout) {
              TextSpan content;
              if (bodyItem.urlsInText.isNotEmpty) {
                List<TextSpan> child = [];

                List<int> indexList = [];

                for (UrlsInText text in bodyItem.urlsInText) {
                  /// 遍历找出所有的匹配的

                  int start = 0;
                  RegExp reg = RegExp(RegExp.escape(text.originalUrl));
                  int index = -1;
                  while ((index =
                          bodyItem.content.substring(start).indexOf(reg)) !=
                      -1) {
                    indexList.add(index);
                    start = index + 1;
                  }
                }

                debugPrint("indexList = $indexList");

                int cur = 0;
                int indexPos = 0;
                while (indexPos < indexList.length) {
                  if (indexList[indexPos] > cur) {
                    child.add(TextSpan(
                        text: bodyItem.content
                            .substring(cur, indexList[indexPos])));
                    cur = indexList[indexPos];
                  } else {
                    int startIndex = indexList[indexPos];
                    int endIndex = startIndex +
                        bodyItem.urlsInText[indexPos].originalUrl.length;

                    child.add(TextSpan(
                        text: bodyItem.urlsInText[indexPos].title,
                        style: TextStyle(color: AppColors.blue)));
                    cur = endIndex;
                    indexPos++;
                  }
                }

                if (cur < bodyItem.content.length) {
                  child.add(TextSpan(
                      text: bodyItem.content
                          .substring(cur, bodyItem.content.length)));
                }

                content = TextSpan(
                    children: child,
                    style: TextStyle(
                      color: AppColors.primaryTextColor,
                      fontSize: 15,
                      letterSpacing: 0.5,
                    ));
              } else {
                content = TextSpan(
                    text: bodyItem.content,
                    style: TextStyle(
                        color: AppColors.primaryTextColor,
                        fontSize: 15,
                        letterSpacing: 0.5));
              }

              var painter = TextPainter(
                textDirection: TextDirection.ltr,
                text: content,
              );

              debugPrint("maxWidth = ${layout.maxWidth}");
              painter.layout(maxWidth: layout.maxWidth);

              var textLine = painter.height / painter.preferredLineHeight;

              debugPrint("text height = ${painter.height}; line = $textLine");

              if (textLine > 8) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text.rich(
                      content,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: AppDimensions.smallPadding,
                    ),
                    Text(
                      '全文',
                      style: TextStyle(
                        color: AppColors.tipsTextColor,
                        fontSize: 16,
                      ),
                    )
                  ],
                );
              }

              return Text.rich(
                content,
              );
            })));
  }
}
