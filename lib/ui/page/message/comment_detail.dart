import 'package:today/data/repository/comment_model.dart';
import 'package:today/ui/ui_base.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:today/ui/message.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';

class CommentDetailPage extends StatefulWidget {
  final Comment comment;

  CommentDetailPage(this.comment);

  @override
  _CommentDetailPageState createState() => _CommentDetailPageState();
}

class _CommentDetailPageState extends State<CommentDetailPage>
    with AfterLayoutMixin<CommentDetailPage> {
  final CommentModel _model = CommentModel();
  final GlobalKey<PhoenixHeaderState> _refreshKey = GlobalKey();
  final GlobalKey<BallPulseFooterState> _loadMoreFooterKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return NormalPage(
      title: NormalTitle('评论详情'),
      body: ScopedModel(
          model: _model,
          child:
              ScopedModelDescendant<CommentModel>(builder: (context, _, model) {
            if (model.commentDetail == null) {
              return PageLoadingWidget();
            }

            return EasyRefresh(
                refreshHeader: PhoenixHeader(key: _refreshKey),
                refreshFooter: BallPulseFooter(
                  key: _loadMoreFooterKey,
                  backgroundColor: Colors.transparent,
                  color: AppColors.accentColor,
                ),
                firstRefresh: false,
                loadMore: () {
                  _model.requestCommentReply(
                      widget.comment.id, widget.comment.targetType,
                      loadMore: true);
                },
                onRefresh: () {
                  afterFirstLayout(context);
                },
                child: CustomScrollView(
                  slivers: <Widget>[
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
                            CommentItemWidget(model.commentDetail),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 40 + AppDimensions.primaryPadding),
                              child: Text(
                                '查看原动态',
                                style: TextStyle(color: AppColors.blue),
                              ),
                            ),
                            SizedBox(
                              height: AppDimensions.primaryPadding,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Builder(builder: (_) {
                        if (model.commentReplyData.isEmpty) {
                          return PageLoadingWidget();
                        }
                        return CommentListWidget(
                            '全部回复', model.commentReplyData);
                      }),
                    )
                  ],
                ));
          })),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _model.requestCommentDetail(widget.comment.id, widget.comment.targetType);
    _model.requestCommentReply(widget.comment.id, widget.comment.targetType);
  }
}
