import 'package:today/ui/ui_base.dart';
import 'package:today/data/model/recommendfeed.dart';

class MessageItem extends StatelessWidget {
  final RecommendItem item;

  MessageItem(this.item);

  @override
  Widget build(BuildContext context) {
    RecommendBodyItem bodyItem = item.item;
    Topic topic = bodyItem.topic;

    Comment topComment = bodyItem.topComment;

    List<UserInfo> involvedUsers = topic.involvedUsers.users;

    List<Widget> involvedUsersWidget = [];

    for (UserInfo user in involvedUsers) {
      involvedUsersWidget.add(Positioned(
          right: involvedUsers.indexOf(user) * 25.0,
          child: AppNetWorkImage(
            src: user.avatarImage.thumbnailUrl,
            width: 30,
            height: 30,
            borderRadius: BorderRadius.circular(15),
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
                      width: 50,
                      height: 50,
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
                          Spacer(),
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
                        maxWidth: 80,
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
                        (bodyItem.content == null ||
                                bodyItem.content.trim().isEmpty
                            ? SizedBox()
                            : Builder(builder: (context) {
                                TextSpan content;
                                if (bodyItem.urlsInText != null &&
                                    bodyItem.urlsInText.isNotEmpty) {
                                  List<TextSpan> child = [];

                                  List<int> indexList = [];

                                  for (UrlsInText text in bodyItem.urlsInText) {
                                    indexList.add(bodyItem.content
                                        .indexOf(RegExp(text.title)));
                                  }

                                  int cur = 0;
                                  int indexPos = 0;
                                  while (indexPos < indexList.length) {
                                    if (indexList[indexPos] > cur) {
                                      child.add(TextSpan(
                                          text: bodyItem.content.substring(
                                              cur, indexList[indexPos])));
                                      cur = indexList[indexPos];
                                    } else {
                                      int startIndex = indexList[indexPos];
                                      int endIndex = startIndex +
                                          bodyItem.urlsInText[indexPos].title
                                              .length;

                                      child.add(TextSpan(
                                          text: bodyItem.content
                                              .substring(startIndex, endIndex),
                                          style: Theme.of(context)
                                              .textTheme
                                              .body1
                                              .merge(TextStyle(
                                                  color: AppColors.blue))));
                                      cur = endIndex;
                                      indexPos++;
                                    }
                                  }

                                  if (cur < bodyItem.content.length) {
                                    child.add(TextSpan(
                                        text: bodyItem.content.substring(
                                            cur, bodyItem.content.length)));
                                  }

                                  content = TextSpan(
                                      children: child,
                                      style: Theme.of(context).textTheme.body1);
                                } else {
                                  content = TextSpan(
                                      text: bodyItem.content,
                                      style: Theme.of(context).textTheme.body1);
                                }

                                return Text.rich(content);
                              })),
                        _createContentWidget(bodyItem),
                        SizedBox(
                          height: AppDimensions.primaryPadding,
                        ),
                        Row(
                          children: <Widget>[
                            AppNetWorkImage(
                              src: bodyItem.user.avatarImage.thumbnailUrl,
                              width: 30,
                              height: 30,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            SizedBox(
                              width: AppDimensions.smallPadding,
                            ),
                            Text(
                              bodyItem.user.screenName,
                              style: TextStyle(
                                  color: AppColors.primaryTextColor,
                                  fontSize: 12),
                            ),
                            SizedBox(
                              width: AppDimensions.smallPadding,
                            ),
                            Builder(builder: (context) {
                              debugPrint(
                                  "trailingIcons = ${bodyItem.user.trailingIcons}");

                              if (bodyItem.user.trailingIcons.isEmpty) {
                                return SizedBox();
                              }

                              List<Widget> images = [];

                              for (TrailingIcons icon
                                  in bodyItem.user.trailingIcons) {
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
                            (bodyItem.user.trailingIcons.isEmpty
                                ? SizedBox()
                                : SizedBox(
                                    width: AppDimensions.smallPadding,
                                  )),
                            Text(
                              '发布',
                              style: TextStyle(
                                  color: AppColors.tipsTextColor, fontSize: 12),
                            ),
                            Spacer(),
                            Builder(builder: (context) {
                              if (bodyItem.poi == null ||
                                  bodyItem.poi.name == null) return SizedBox();

                              return Text(
                                bodyItem.poi.name,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.tipsTextColor),
                              );
                            })
                          ],
                        ),
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
                            if (topComment.pictures == null ||
                                topComment.pictures.isEmpty) return SizedBox();

                            debugPrint(
                                "topComent picture: ${topComment.pictures}");

                            double width =
                                topComment.pictures.first.width.toDouble();
                            double height =
                                topComment.pictures.first.height.toDouble();

                            while (width > layout.maxWidth || height > 200) {
                              width /= 2;
                              height /= 2;
                            }

                            return Container(
                              margin: EdgeInsets.only(
                                  top: AppDimensions.primaryPadding),
                              child: AppNetWorkImage(
                                src: topComment.pictures.first.thumbnailUrl,
                                width: width,
                                height: height,
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

  Widget _createContentWidget(RecommendBodyItem bodyItem) {
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
              height: AppDimensions.smallPadding,
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
                      : AppDimensions.primaryPadding)),
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
