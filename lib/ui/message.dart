import 'package:intl/intl.dart' as intl;
import 'package:today/ui/page/message/comment_detail.dart';
import 'package:today/ui/ui_base.dart';
import 'package:today/data/model/recommendfeed.dart';
import 'package:today/ui/page/picture_detail.dart';
import 'package:today/ui/page/message/message_detail.dart';
import 'package:today/widget/real_rich_text.dart';
import 'package:today/ui/page/message/video_list.dart';

final intl.DateFormat _dateFormat = intl.DateFormat('MM/dd HH:mm');

class MessageItem extends StatelessWidget {
  final RecommendItem item;
  final bool needMarginTop;

  MessageItem(this.item, {this.needMarginTop = true});

  @override
  Widget build(BuildContext context) {
    Message bodyItem = item.item;

    if (item.type == 'SPLIT_BAR') {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            BlocProvider.of<RecommendBloc>(context)
                .dispatch(FetchRecommendEvent());
          },
          child: Padding(
            padding:
                EdgeInsets.symmetric(vertical: AppDimensions.primaryPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('images/ic_tabbar_refresh.png'),
                SizedBox(
                  width: AppDimensions.smallPadding,
                ),
                Text(
                  item.text,
                  style: TextStyle(
                      fontSize: 11, color: AppColors.primaryTextColor),
                )
              ],
            ),
          ),
        ),
      );
    } else if (item.type == 'BULLETIN') {
      debugPrint('BULLETIN viewType = ${item.viewType}');

      return Padding(
        padding: EdgeInsets.only(
          bottom: AppDimensions.primaryPadding,
          top: AppDimensions.primaryPadding,
        ),
        child: Material(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: AppDimensions.primaryPadding,
                    horizontal: AppDimensions.primaryPadding),
                child: Row(
                  children: <Widget>[
                    AppNetWorkImage(
                      src: item.picture.thumbnailUrl,
                      width: 60,
                      height: 60,
                    ),
                    SizedBox(
                      width: AppDimensions.primaryPadding,
                    ),
                    Expanded(
                        child: SizedBox(
                      height: 60,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            item.title,
                            style: TextStyle(
                                fontSize: 16,
                                color: AppColors.primaryTextColor),
                          ),
                          Text(
                            item.content,
                            style: TextStyle(color: AppColors.normalTextColor),
                          ),
                        ],
                      ),
                    ))
                  ],
                ),
              ),
              Divider(
                height: 0.5,
                color: AppColors.dividerGrey,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: AppDimensions.primaryPadding),
                child: Text(
                  item.button.text,
                  style: TextStyle(fontSize: 12, color: AppColors.blue),
                ),
              )
            ],
          ),
        ),
      );
    }

    /// type: RECOMMENDED_MESSAGE
    Topic topic = bodyItem.topic;

    Comment topComment = bodyItem.topComment;

    List<UserInfo> involvedUsers = topic.involvedUsers.users.reversed.toList();

    List<Widget> involvedUsersWidget = [];

    for (UserInfo user in involvedUsers) {
      involvedUsersWidget.add(Positioned(
          right: involvedUsers.indexOf(user) * 20.0,
          child: AppNetWorkImage(
            src: user.avatarImage.thumbnailUrl,
            width: 25,
            height: 25,
            borderRadius: BorderRadius.circular(13),
          )));
    }

    return Container(
      margin: EdgeInsets.only(
          top: (needMarginTop ? AppDimensions.primaryPadding + 3 : 0)),
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return MessageDetailPage(
                id: item.id,
                ref: bodyItem.user.ref,
                pageName: 'tab_recommend',
              );
            }));
          },
          child: Column(
            children: <Widget>[
              Container(
                height: 60,
                alignment: Alignment.center,
                color: AppColors.topicBackground,
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.primaryPadding),
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
                        RichTextWidget(bodyItem),
                        MessageBodyWidget(bodyItem),
                        LinkInfoWidget(bodyItem),
                        SizedBox(
                          height: AppDimensions.primaryPadding,
                        ),
                        Builder(builder: (context) {
                          UserInfo user = bodyItem.user;

                          if (user == null) return SizedBox();

                          return Row(
                            children: <Widget>[
                              AvatarWidget(
                                user,
                                size: 26,
                              ),
                              SizedBox(
                                width: AppDimensions.smallPadding,
                              ),
                              ScreenNameWidget(user: user),
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

                                return LimitedBox(
                                  maxWidth: 200,
                                  child: Text(
                                    bodyItem.poi.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.tipsTextColor),
                                  ),
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
                      margin: EdgeInsets.only(
                          left: AppDimensions.primaryPadding,
                          right: AppDimensions.primaryPadding,
                          bottom: AppDimensions.primaryPadding),
                      child: Material(
                        color: Colors.grey[50],
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return MessageDetailPage(
                                id: item.id,
                                pageName: 'tab_recommend',
                                ref: bodyItem.user.ref,
                              );
                            }));
                          },
                          child: Container(
                            color: Colors.transparent,
                            padding:
                                EdgeInsets.all(AppDimensions.primaryPadding),
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
                                  height: AppDimensions.smallPadding,
                                ),
                                Builder(builder: (context) {
                                  TapGestureRecognizer tap =
                                      TapGestureRecognizer();
                                  tap.onTap = () {
                                    Fluttertoast.showToast(
                                        msg: topComment.user.screenName);
                                  };

                                  List<TextSpan> child = [];

                                  if (topComment.level > 2) {
                                    /// 多级回复
                                    child.add(TextSpan(
                                        text: '${topComment.user.screenName}',
                                        style:
                                            TextStyle(color: AppColors.blue)));
                                    child.add(TextSpan(text: ' 回复 '));
                                    child.add(TextSpan(
                                        text:
                                            '${topComment.replyToComment.user.screenName}：',
                                        style:
                                            TextStyle(color: AppColors.blue)));
                                  } else {
                                    child.add(TextSpan(
                                        text: '${topComment.user.screenName}：',
                                        style:
                                            TextStyle(color: AppColors.blue)));
                                  }

                                  child.addAll(_parseUrlsInText(
                                      topComment.urlsInText,
                                      topComment.content));

                                  return Text.rich(
                                    TextSpan(children: child),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: AppColors.primaryTextColor),
                                  );
                                }),
                                LayoutBuilder(builder: (context, layout) {
                                  if (topComment.pictures.isEmpty)
                                    return SizedBox();

                                  double width = topComment.pictures.first.width
                                      .toDouble();
                                  double height = topComment
                                      .pictures.first.height
                                      .toDouble();
                                  double maxWidth =
                                      MediaQuery.of(context).size.width;
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
                                          tag: topComment.pictures.first,
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
                                                src: topComment.pictures.first
                                                    .thumbnailUrl,
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
                                            child: MessageBodyWidget
                                                ._createImageType(
                                                    topComment.pictures.first),
                                          );
                                        }),
                                      ],
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ),
                      ))),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.primaryPadding),
                child: Divider(
                  height: 1,
                  color: AppColors.dividerGrey,
                ),
              ),
              CommentWidget(bodyItem: bodyItem),
            ],
          ),
        ),
      ),
    );
  }
}

class LinkInfoWidget extends StatelessWidget {
  final Message bodyItem;

  LinkInfoWidget(this.bodyItem);

  @override
  Widget build(BuildContext context) {
    return _createLinkInfoWidget(bodyItem, context);
  }

  Widget _createLinkInfoWidget(Message bodyItem, BuildContext context) {
    LinkInfo linkInfo = bodyItem.linkInfo;
    if (linkInfo == null) return SizedBox();

    if (linkInfo.audio != null) {
      /// 音视频

      Audio audio = linkInfo.audio;

      debugPrint('audio = $audio');

      return Container(
        color: AppColors.darkGrey,
        height: 70,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 70,
              height: 70,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  AppNetWorkImage(
                    src: audio.image.thumbnailUrl,
                    width: 70,
                    height: 70,
                  ),
                  Image.asset('images/ic_mediaplayer_musicplayer_play.png')
                ],
              ),
            ),
            SizedBox(
              width: AppDimensions.primaryPadding,
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  audio.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: AppColors.primaryTextColor),
                ),
                SizedBox(
                  height: AppDimensions.smallPadding,
                ),
                Text(
                  audio.author,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(color: AppColors.normalTextColor, fontSize: 12),
                ),
              ],
            ))
          ],
        ),
      );
    } else if (linkInfo.video != null) {
      Video video = linkInfo.video;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          VideoPreviewWidget(
            video: video,
            message: bodyItem,
          ),
          LayoutBuilder(
            builder: (_, layout) {
              return Container(
                width: layout.maxWidth,
                color: AppColors.topicBackground,
                padding: EdgeInsets.symmetric(
                    vertical: AppDimensions.primaryPadding * 2,
                    horizontal: AppDimensions.primaryPadding),
                child: Text(
                  linkInfo.title,
                  style: TextStyle(color: AppColors.tipsTextColor),
                ),
              );
            },
          )
        ],
      );
    } else {
      /// 分享链接
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return WebViewPage(linkInfo.linkUrl, linkInfo.title);
          }));
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: AppColors.darkGrey),
          height: 60,
          child: Row(
            children: <Widget>[
              AppNetWorkImage(
                src: linkInfo.pictureUrl,
                width: 60,
                height: 60,
              ),
              SizedBox(
                width: AppDimensions.primaryPadding,
              ),
              Expanded(
                child: Text(
                  linkInfo.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: AppColors.primaryTextColor),
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    Key key,
    @required this.bodyItem,
  }) : super(key: key);

  final Message bodyItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.primaryPadding, vertical: 15),
      child: Row(
        children: <Widget>[
          Image.asset('images/ic_messages_like_unselected.png'),
          SizedBox(
            width: 4,
          ),
          Text(bodyItem.likeCount.toString(),
              style: TextStyle(fontSize: 12, color: AppColors.tipsTextColor)),
          SizedBox(
            width: 80,
          ),
          Image.asset('images/ic_messages_comment.png'),
          SizedBox(
            width: 4,
          ),
          Text(bodyItem.commentCount.toString(),
              style: TextStyle(fontSize: 12, color: AppColors.tipsTextColor)),
          SizedBox(
            width: 80,
          ),
          Image.asset('images/ic_messages_share.png'),
          SizedBox(
            width: 4,
          ),
          Text(bodyItem.shareCount.toString(),
              style: TextStyle(fontSize: 12, color: AppColors.tipsTextColor)),
          Spacer(),
          Image.asset('images/ic_messages_more.png'),
        ],
      ),
    );
  }
}

class RichTextWidget extends StatelessWidget {
  final Message bodyItem;
  final bool showFullContent;

  RichTextWidget(this.bodyItem, {this.showFullContent = false});

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
                text: content,
                textDirection: TextDirection.ltr,
              );

              debugPrint("maxWidth = ${layout.maxWidth}");
              painter.layout(maxWidth: layout.maxWidth);

              var textLine = painter.height / painter.preferredLineHeight;

              debugPrint("text height = ${painter.height}; line = $textLine");

              if (!showFullContent && textLine > 8) {
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

class MessageBodyWidget extends StatelessWidget {
  final Message bodyItem;

  MessageBodyWidget(this.bodyItem);

  @override
  Widget build(BuildContext context) {
    return _createContentWidget(bodyItem, context);
  }

  Widget _createContentWidget(Message bodyItem, BuildContext context) {
    if (bodyItem.video != null) {
      /// video
      /// fix width
      var video = bodyItem.video;
      return Container(
        margin: EdgeInsets.only(top: AppDimensions.smallPadding),
        child: VideoPreviewWidget(
          video: video,
          message: bodyItem,
        ),
      );
    } else if (bodyItem.pictures.isNotEmpty) {
      /// 图片

      List<Picture> pictures = bodyItem.pictures;

      if (pictures.length == 1) {
        /// 单个
        return SingleImageWidget(pictures.single);
      } else {
        /// 九宫格

        int axisCount = 3;
        return GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.only(
              top: (bodyItem.content.trim().isEmpty
                  ? 0
                  : AppDimensions.smallPadding)),
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
                      tag: picture,
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

  static Widget _createImageType(Picture picture) {
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

class VideoPreviewWidget extends StatelessWidget {
  const VideoPreviewWidget(
      {Key key, @required this.video, @required this.message})
      : super(key: key);

  final Video video;
  final Message message;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return VideoListPage(message);
          }));
        },
        child: SizedBox(
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
        ),
      );
    });
  }
}

class SingleImageWidget extends StatelessWidget {
  final Picture picture;

  SingleImageWidget(this.picture);

  @override
  Widget build(BuildContext context) {
    if (picture.width <= 0 || picture.height <= 0) {
      return SizedBox(
        width: 0,
        height: 0,
      );
    }

    double width = picture.width.toDouble();
    double height = picture.height.toDouble();
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
                  tag: picture,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return PictureDetailPage([picture]);
                        }));
                      },
                      child: AppNetWorkImage(
                        src: picture.thumbnailUrl,
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
                    child: MessageBodyWidget._createImageType(picture)),
              ],
            );
          },
        ),
      ],
    );
  }
}

class ScreenNameWidget extends StatelessWidget {
  const ScreenNameWidget(
      {Key key,
      @required this.user,
      this.textColor = AppColors.primaryTextColor,
      this.fontSize = 14})
      : super(key: key);

  final UserInfo user;
  final Color textColor;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          user.screenName,
          style: TextStyle(color: textColor, fontSize: fontSize),
        ),
        Builder(builder: (_) {
          if (user.isVerified) {
            return Text(
              '（${user.verifyMessage}）',
              style: TextStyle(color: AppColors.normalTextColor, fontSize: 12),
            );
          }
          return SizedBox();
        }),
        SizedBox(
          width: AppDimensions.smallPadding / 2,
        ),
        Builder(builder: (context) {
          if (user.trailingIcons.isEmpty) {
            return SizedBox();
          }

          List<Widget> images = [];

          for (TrailingIcons icon in user.trailingIcons) {
            images.add(AppNetWorkImage(
              src: icon.picUrl,
              width: 15,
              height: 15,
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
      ],
    );
  }
}

class CommentListWidget extends StatelessWidget {
  final List<Comment> commentData;
  final String title;

  CommentListWidget(this.title, this.commentData);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.primaryPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: AppDimensions.primaryPadding,
          ),
          Text(
            title,
            style: TextStyle(color: AppColors.primaryTextColor),
          ),
          SizedBox(
            height: AppDimensions.primaryPadding,
          ),
          Divider(
            height: 1,
            color: AppColors.dividerGrey,
          ),
          ListView.separated(
            itemBuilder: (_, index) {
              Comment comment = commentData[index];
              return CommentItemWidget(comment);
            },
            separatorBuilder: (_, index) {
              return Padding(
                padding: EdgeInsets.only(
                    left: 20 +
                        AppDimensions.primaryPadding +
                        AppDimensions.primaryPadding),
                child: Divider(
                  height: 1,
                  color: AppColors.dividerGrey,
                ),
              );
            },
            itemCount: commentData.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}

class CommentItemWidget extends StatelessWidget {
  final Comment comment;
  final bool needJumpDetail;

  CommentItemWidget(this.comment, {this.needJumpDetail = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppDimensions.primaryPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AvatarWidget(comment.user),
          SizedBox(
            width: AppDimensions.primaryPadding,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ScreenNameWidget(user: comment.user),
                    Row(
                      children: <Widget>[
                        Text(
                          '${comment.likeCount}',
                          style: TextStyle(
                              fontSize: 12, color: AppColors.tipsTextColor),
                        ),
                        SizedBox(
                          width: AppDimensions.smallPadding,
                        ),
                        Image.asset((comment.liked
                            ? 'images/ic_comment_like_selected.png'
                            : 'images/ic_comment_like.png')),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: AppDimensions.smallPadding,
                ),
                Text(
                  _dateFormat
                      .format(DateTime.parse(comment.createdAt).toLocal()),
                  style:
                      TextStyle(fontSize: 10, color: AppColors.tipsTextColor),
                ),
                Builder(
                  builder: (_) {
                    if (comment.content.isEmpty) return SizedBox();

                    return Column(
                      children: <Widget>[
                        SizedBox(
                          height: AppDimensions.smallPadding,
                        ),
                        Builder(
                          builder: (_) {
                            List<TextSpan> child = [];

                            if (comment.level > 2) {
                              /// 多级回复

                              child.add(TextSpan(text: '回复'));
                              child.add(TextSpan(
                                  text:
                                      ' ${comment.replyToComment.user.screenName}：',
                                  style: TextStyle(color: AppColors.blue)));
                            }

                            child.addAll(_parseUrlsInText(
                                comment.urlsInText, comment.content));

                            return Text.rich(TextSpan(
                                children: child,
                                style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.primaryTextColor)));
                          },
                        ),
                      ],
                    );
                  },
                ),
                Builder(builder: (_) {
                  if (comment.pictures.isEmpty) return SizedBox();

                  return SingleImageWidget(comment.pictures.first);
                }),
                Builder(builder: (_) {
                  /// 热门回复
                  if (comment.hotReplies.isEmpty) return SizedBox();

                  List<Widget> commentList = comment.hotReplies.map((data) {
                    List<TextSpan> child = [];

                    int index = comment.hotReplies.indexOf(data);

                    if (data.level > 2) {
                      /// 多级回复
                      child.add(TextSpan(
                          text: '${data.user.screenName}',
                          style: TextStyle(
                            color: AppColors.blue,
                          )));
                      child.add(TextSpan(text: ' 回复 '));
                      child.add(TextSpan(
                          text: '${data.replyToComment.user.screenName}：',
                          style: TextStyle(
                            color: AppColors.blue,
                          )));
                    } else {
                      child.add(TextSpan(
                          text: '${data.user.screenName}：',
                          style: TextStyle(
                            color: AppColors.blue,
                          )));
                    }

                    if (data.content.isNotEmpty) {
                      child.addAll(
                          _parseUrlsInText(data.urlsInText, data.content));
                    }

                    if (data.pictures.isNotEmpty) {
                      TapGestureRecognizer detail = TapGestureRecognizer();
                      detail.onTap = () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return PictureDetailPage(
                            data.pictures,
                          );
                        }));
                      };

                      child.add(ImageSpan(
                          AssetImage('images/ic_feedback_sendpic.png'),
                          imageWidth: 15,
                          imageHeight: 15,
                          color: AppColors.blue,
                          margin: EdgeInsets.only(
                              right: AppDimensions.smallPadding)));

                      child.add(TextSpan(
                        text: '查看图片',
                        style: TextStyle(
                          color: AppColors.blue,
                        ),
                        recognizer: detail,
                      ));
                    }

                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: (index != (comment.hotReplies.length - 1)
                              ? AppDimensions.smallPadding
                              : 0)),
                      child: RealRichText(
                        child,
                        style: TextStyle(color: AppColors.primaryTextColor),
                      ),
                    );
                  }).toList();

                  if (comment.hotReplies.length < comment.replyCount) {
                    commentList.add(Padding(
                      padding: EdgeInsets.only(top: AppDimensions.smallPadding),
                      child: Text(
                        '共${comment.replyCount}条回复>',
                        style: TextStyle(color: AppColors.blue),
                      ),
                    ));
                  }

                  return LayoutBuilder(
                    builder: (_, layout) {
                      return Container(
                        width: layout.maxWidth,
                        margin:
                            EdgeInsets.only(top: AppDimensions.smallPadding),
                        child: Material(
                          color: AppColors.commentBackgroundGray,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (_) {
                                return CommentDetailPage(comment);
                              }));
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: AppDimensions.primaryPadding,
                                  horizontal: AppDimensions.smallPadding),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: commentList,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AvatarWidget extends StatelessWidget {
  final UserInfo user;
  final double size;

  AvatarWidget(this.user, {this.size = 40});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: <Widget>[
          AppNetWorkImage(
            src: user.avatarImage.thumbnailUrl,
            width: size,
            height: size,
            borderRadius: BorderRadius.circular(size / 2),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Builder(builder: (_) {
              if (user.isVerified) {
                return Image.asset(
                  'images/ic_common_verified.png',
                  width: size / 2.5,
                  height: size / 2.5,
                );
              }
              return SizedBox();
            }),
          ),
        ],
      ),
    );
  }
}

List<TextSpan> _parseUrlsInText(List<UrlsInText> urlsInText, String content) {
  List<TextSpan> child = [];

  List<int> indexList = [];

  for (UrlsInText text in urlsInText) {
    /// 遍历找出所有的匹配的

    int start = 0;
    RegExp reg = RegExp(RegExp.escape(text.originalUrl));
    int index = -1;
    while ((index = content.substring(start).indexOf(reg)) != -1) {
      indexList.add(index);
      start = index + 1;
    }
  }

  debugPrint("indexList = $indexList");

  int cur = 0;
  int indexPos = 0;
  while (indexPos < indexList.length) {
    if (indexList[indexPos] > cur) {
      child.add(TextSpan(text: content.substring(cur, indexList[indexPos])));
      cur = indexList[indexPos];
    } else {
      int startIndex = indexList[indexPos];
      int endIndex = startIndex + urlsInText[indexPos].originalUrl.length;

      child.add(TextSpan(
          text: urlsInText[indexPos].title,
          style: TextStyle(color: AppColors.blue)));
      cur = endIndex;
      indexPos++;
    }
  }

  if (cur < content.length) {
    child.add(TextSpan(text: content.substring(cur, content.length)));
  }

  return child;
}
