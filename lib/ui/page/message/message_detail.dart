import 'package:today/ui/ui_base.dart';
import 'package:today/data/repository/message_model.dart';
import 'package:today/ui/message.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';
import 'package:intl/intl.dart';
import 'package:today/data/repository/comment_model.dart';

/// 时间少了 8 小时
final DateFormat _dateFormat = DateFormat('MM/dd HH:mm', 'zh_CN');

/// 消息详情
class MessageDetailPage extends StatefulWidget {
  final String id;
  final String ref;
  final String pageName;

  MessageDetailPage({@required this.id, this.ref, this.pageName});

  @override
  State<StatefulWidget> createState() {
    return _MessageDetailState();
  }
}

class _MessageDetailState extends State<MessageDetailPage>
    with AfterLayoutMixin<MessageDetailPage> {
  final MessageModel _messageModel = MessageModel();
  final GlobalKey<PhoenixHeaderState> _refreshHeaderKey = GlobalKey();

  @override
  void afterFirstLayout(BuildContext context) {
    _messageModel.requestMessageDetail(widget.id,
        ref: widget.ref, pageName: widget.pageName);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MessageModel>(
      model: _messageModel,
      child: ScopedModelDescendant<MessageModel>(
        builder: (BuildContext context, Widget child, MessageModel model) {
          if (model.message == null) {
            return NormalPage(
              body: PageLoadingWidget(),
              title: NormalTitle('动态详情'),
            );
          }

          Message message = model.message;
          UserInfo user = message.user;

          return NormalPage(
            needAppBar: false,
            body: EasyRefresh(
                refreshHeader: PhoenixHeader(
                  key: _refreshHeaderKey,
                ),
                onRefresh: () {},
                firstRefresh: false,
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      title: NormalTitle('消息详情'),
                      pinned: true,
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        color: Colors.white,
                        margin: EdgeInsets.only(
                            bottom: AppDimensions.primaryPadding),
                        padding: EdgeInsets.symmetric(
                            horizontal: AppDimensions.primaryPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: AppDimensions.primaryPadding,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                AppNetWorkImage(
                                  src: user.avatarImage.thumbnailUrl,
                                  width: 40,
                                  height: 40,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                SizedBox(
                                  width: AppDimensions.primaryPadding,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          user.screenName,
                                          style: TextStyle(
                                              color:
                                                  AppColors.primaryTextColor),
                                        ),
                                        SizedBox(
                                          width: AppDimensions.smallPadding,
                                        ),
                                        Builder(builder: (context) {
                                          if (user.trailingIcons.isEmpty) {
                                            return SizedBox();
                                          }

                                          List<Widget> images = [];

                                          for (TrailingIcons icon
                                              in user.trailingIcons) {
                                            images.add(AppNetWorkImage(
                                              src: icon.picUrl,
                                              width: 15,
                                              height: 15,
                                              borderRadius:
                                                  BorderRadius.circular(0),
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
                                    ),
                                    SizedBox(
                                      height: AppDimensions.smallPadding,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          _dateFormat.format(DateTime.parse(
                                              message.createdAt)),
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: AppColors.tipsTextColor),
                                        ),
                                        Builder(builder: (_) {
                                          if (message.poi == null)
                                            return SizedBox();

                                          return Row(
                                            children: <Widget>[
                                              SizedBox(
                                                width:
                                                    AppDimensions.smallPadding,
                                              ),
                                              Image.asset(
                                                  'images/ic_personaltab_activity_add_location.png'),
                                              SizedBox(
                                                width:
                                                    AppDimensions.smallPadding,
                                              ),
                                              Text(
                                                message.poi.name,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: AppColors
                                                        .tipsTextColor),
                                              )
                                            ],
                                          );
                                        }),
                                      ],
                                    )
                                  ],
                                ),
                                Spacer(),
                                Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.blue,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: GestureDetector(
                                    onTap: () {},
                                    behavior: HitTestBehavior.opaque,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 15),
                                      child: Text(
                                        '关注',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: AppDimensions.primaryPadding / 2 * 3,
                                ),
                                Image.asset(
                                    'images/ic_messages_collect_unselected.png'),
                              ],
                            ),
                            SizedBox(
                              height: AppDimensions.smallPadding,
                            ),
                            RichTextWidget(
                              message,
                              showFullContent: true,
                            ),
                            MessageBodyWidget(message),
                            SizedBox(
                              height: AppDimensions.primaryPadding,
                            ),
                            _createTopic(message),
                            SizedBox(
                              height: AppDimensions.primaryPadding,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: AppDimensions.primaryPadding),
                              child: Divider(
                                height: 1,
                                color: AppColors.dividerGrey,
                              ),
                            ),
                            CommentWidget(bodyItem: message),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: _RelatedWidget(
                        listRelated: model.listRelated,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: _CommentListWidget(message),
                    )
                  ],
                )),
          );
        },
      ),
    );
  }

  Widget _createTopic(Message message) {
    Topic topic = message.topic;

    return Container(
      color: AppColors.topicBackground,
      padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.primaryPadding,
          vertical: AppDimensions.smallPadding),
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
                            color: AppColors.tipsTextColor, fontSize: 11));
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.blue, width: 1),
                borderRadius: BorderRadius.circular(12),
                shape: BoxShape.rectangle),
            child: Center(
              child: Text(
                '加入',
                style: TextStyle(fontSize: 12, color: AppColors.blue),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PageLoadingWidget extends StatelessWidget {
  const PageLoadingWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        height: 20,
        child: SpinKitThreeBounce(
          size: 20,
          color: Colors.grey,
          duration: Duration(milliseconds: 1000),
        ),
      ),
    );
  }
}

class _RelatedWidget extends StatelessWidget {
  final PageController _pageController = PageController(viewportFraction: 0.9);

  final List<Message> listRelated;

  _RelatedWidget({this.listRelated = const []});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: AppDimensions.primaryPadding),
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.primaryPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: AppDimensions.primaryPadding,
          ),
          Text(
            '相关推荐',
            style: TextStyle(color: AppColors.primaryTextColor),
          ),
          SizedBox(
            height: AppDimensions.primaryPadding,
          ),
          Divider(
            height: 1,
            color: AppColors.dividerGrey,
          ),
          SizedBox(
            height: 100,
            child: LayoutBuilder(
              builder: (_, layout) {
                return PageView.builder(
                  itemBuilder: (_, index) {
                    Message item = listRelated[index];
                    return Transform.translate(
                      offset: Offset(-(layout.maxWidth * 0.1 / 2), 0),
                      child: Row(
                        children: <Widget>[
                          Builder(
                            builder: (_) {
                              String imgUrl =
                                  item.user.avatarImage.thumbnailUrl;

                              if (item.video != null) {
                                imgUrl = item.video.image.thumbnailUrl;
                              } else if (item.pictures.isNotEmpty) {
                                imgUrl = item.pictures.first.thumbnailUrl;
                              } else if (item.linkInfo != null) {
                                imgUrl = item.linkInfo.pictureUrl;
                              }

                              if (imgUrl.isEmpty) {
                                return SizedBox();
                              }

                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  AppNetWorkImage(
                                    src: imgUrl,
                                    height: 70,
                                    width: 70,
                                  ),
                                  _createImageType(listRelated[index]),
                                ],
                              );
                            },
                          ),
                          SizedBox(
                            width: AppDimensions.primaryPadding,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 70,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Text(
                                    item.content,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Image.asset(
                                        'images/ic_personal_tab_my_topic.png',
                                      ),
                                      SizedBox(
                                        width: AppDimensions.smallPadding / 2,
                                      ),
                                      Text(
                                        item.topic.content,
                                        style: TextStyle(
                                            color: AppColors.tipsTextColor,
                                            fontSize: 12),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: listRelated.length,
                  physics: BouncingScrollPhysics(),
                  controller: _pageController,
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _createImageType(Message message) {
    if (message.video != null) {
      /// video
      return Image.asset('images/ic_personaltab_activity_video_play.png');
    } else if (message.pictures.isNotEmpty &&
        message.pictures.first.format == 'gif') {
      return Image.asset('images/ic_personaltab_activity_gif.png');
    }

    return SizedBox();
  }
}

/// 评论列表
class _CommentListWidget extends StatefulWidget {
  final Message message;

  _CommentListWidget(this.message);

  @override
  __CommentListWidgetState createState() => __CommentListWidgetState();
}

class __CommentListWidgetState extends State<_CommentListWidget>
    with AfterLayoutMixin<_CommentListWidget> {
  final CommentModel _model = CommentModel();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<CommentModel>(
        model: _model,
        child: ScopedModelDescendant<CommentModel>(builder: (_, child, model) {
          if (model.commentList == null) {
            return PageLoadingWidget();
          }

          return Column(
            children: <Widget>[
              Builder(builder: (_) {
                if (model.commentList.hotComments.isEmpty) {
                  return SizedBox();
                }

                /// 热门评论
                return Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(bottom: AppDimensions.primaryPadding),
                  padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.primaryPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: AppDimensions.primaryPadding,
                      ),
                      Text(
                        '热门评论',
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
                          Comment comment =
                              model.commentList.hotComments[index];
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
                        shrinkWrap: true,
                        itemCount: model.commentList.hotComments.length,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                );
              }),
              Builder(builder: (_) {
                /// 最新评论
                return Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.primaryPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: AppDimensions.primaryPadding,
                      ),
                      Text(
                        '最新评论',
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
                          Comment comment = model.commentData[index];
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
                        itemCount: model.commentData.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                );
              }),
            ],
          );
        }));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _model.requestCommentList(widget.message.id, widget.message.type);
  }
}

class CommentItemWidget extends StatelessWidget {
  final Comment comment;

  CommentItemWidget(this.comment);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppDimensions.primaryPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppNetWorkImage(
            src: comment.user.avatarImage.thumbnailUrl,
            width: 40,
            height: 40,
            borderRadius: BorderRadius.circular(20),
          ),
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
                    Text(
                      comment.user.screenName,
                      style: TextStyle(
                          color: AppColors.normalTextColor, fontSize: 13),
                    ),
                    Image.asset((comment.liked
                        ? 'images/ic_comment_like.png'
                        : 'images/ic_comment_like.png'))
                  ],
                ),
                SizedBox(
                  height: AppDimensions.smallPadding,
                ),
                Text(
                  _dateFormat.format(DateTime.parse(comment.createdAt)),
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
                        Text(
                          comment.content,
                          style: TextStyle(
                              color: AppColors.primaryTextColor, fontSize: 13),
                        ),
                      ],
                    );
                  },
                ),
                Builder(builder: (_) {
                  if (comment.pictures.isEmpty) return SizedBox();

                  return SingleImageWidget(comment.pictures.first);
                })
              ],
            ),
          )
        ],
      ),
    );
  }
}
