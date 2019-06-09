import 'package:today/ui/ui_base.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:today/widget/message.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';

class CommentDetailPage extends StatefulWidget {
  final Comment comment;

  CommentDetailPage(this.comment);

  @override
  _CommentDetailPageState createState() => _CommentDetailPageState();
}

class _CommentDetailPageState extends State<CommentDetailPage>
    with AfterLayoutMixin<CommentDetailPage> {
  final CommentDetailBloc _detailBloc = CommentDetailBloc();
  final CommentReplyBloc _commentReplyBloc = CommentReplyBloc();

  final GlobalKey<PhoenixHeaderState> _refreshKey = GlobalKey();
  final GlobalKey<BallPulseFooterState> _loadMoreFooterKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return NormalPage(
      title: NormalTitle('评论详情'),
      body: BlocBuilder(
          bloc: _detailBloc,
          builder: (_, CommentDetailState state) {
            if (state is LoadedCommentDetailState) {
              return EasyRefresh(
                  refreshHeader: PhoenixHeader(key: _refreshKey),
                  refreshFooter: BallPulseFooter(
                    key: _loadMoreFooterKey,
                    backgroundColor: Colors.transparent,
                    color: AppColors.accentColor,
                  ),
                  firstRefresh: false,
                  loadMore: () {
                    _commentReplyBloc.dispatch(FetchCommentReplyEvent(
                        widget.comment.id,
                        targetType: widget.comment.targetType,
                        loadMore: true));
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
                              CommentItemWidget(state.comment),
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
                        child: BlocBuilder(
                            bloc: _commentReplyBloc,
                            builder: (_, state) {
                              if (state is LoadedCommentReplyState) {
                                return CommentListWidget('全部回复', state.comment);
                              }

                              return PageLoadingWidget();
                            }),
                      )
                    ],
                  ));
            }
            return PageLoadingWidget();
          }),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _detailBloc.dispatch(FetchCommentDetailEvent(widget.comment.id,
        targetType: widget.comment.targetType));
    _commentReplyBloc.dispatch(FetchCommentReplyEvent(widget.comment.id,
        targetType: widget.comment.targetType));
  }
}
