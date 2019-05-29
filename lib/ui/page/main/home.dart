import 'package:today/ui/ui_base.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:today/ui/page/debug.dart';
import 'package:today/ui/message.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:today/data/repository/recommend_model.dart';
import 'package:today/ui/page/message/message_detail.dart';

class HomePage extends StatelessWidget {
  final RecommendModel _model = RecommendModel();

  final Function(bool) canRefresh;

  HomePage(this.canRefresh);

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      child: _HomeBody(canRefresh),
      model: _model,
    );
  }
}

class _HomeBody extends StatefulWidget {
  final Function(bool) canRefreshStream;

  _HomeBody(this.canRefreshStream);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<_HomeBody>
    with AfterLayoutMixin<_HomeBody>, WidgetsBindingObserver {
  StreamSubscription _tokenSubscription;
  StreamSubscription _homeSubscription;

  Function _showToastFun;
  RecommendModel _model;

  ScrollController _scrollController = ScrollController();

  final GlobalKey<EasyRefreshState> _refreshKey = GlobalKey();

  final GlobalKey<PhoenixHeaderState> _refreshHeaderKey = GlobalKey();

  final GlobalKey<BallPulseFooterState> _loadMoreFooterKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _tokenSubscription =
        Global.eventBus.on<RefreshTokenEvent>().listen((event) {
      afterFirstLayout(context);
    });
    _homeSubscription = Global.eventBus.on<RefreshHomeEvent>().listen((event) {
      _scrollController.jumpTo(0);
      _refreshKey.currentState.callRefresh();
    });
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _model = RecommendModel.of(context);
    _model.requestRecommendData();
    _showToastFun = () {
      if (_model.recommendFee == null ||
          _model.recommendFee.toastMessage.isEmpty) {
        return;
      }

      Future.delayed(Duration(milliseconds: 300), () {
        Fluttertoast.showToast(
            msg: _model.recommendFee.toastMessage,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: AppColors.accentColor,
            textColor: AppColors.primaryTextColor,
            gravity: ToastGravity.TOP,
            fontSize: 14);
      });
    };
    _model.addListener(_showToastFun);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _tokenSubscription?.cancel();
    _model.removeListener(_showToastFun);
    _scrollController.dispose();
    _homeSubscription?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint("lifecycleState = $state");
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<RecommendModel>(
      builder: (context, _, model) {
        if (model.recommendFee == null) {
          return Column(
            children: <Widget>[
              Container(
                color: AppColors.accentColor,
                height: MediaQuery.of(context).padding.top,
              ),
              _SearchWidget(
                  SearchPlaceholder(
                    '',
                    '',
                    '',
                    '',
                  ),
                  55),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: SpinKitThreeBounce(
                    size: 20,
                    color: Colors.grey,
                    duration: Duration(milliseconds: 1000),
                  ),
                ),
              ),
            ],
          );
        }

        return Column(
          children: <Widget>[
            Container(
              color: Color(0xffffe411),
              height: MediaQuery.of(context).padding.top,
            ),
            Expanded(
              child: NotificationListener<ScrollUpdateNotification>(
                onNotification: (notification) {
                  widget.canRefreshStream(
                      _scrollController.position.pixels > 2000);
                },
                child: EasyRefresh(
                  key: _refreshKey,
                  firstRefresh: false,
                  refreshHeader: PhoenixHeader(
                    key: _refreshHeaderKey,
                  ),
                  refreshFooter: BallPulseFooter(
                    key: _loadMoreFooterKey,
                    backgroundColor: Colors.transparent,
                    color: AppColors.accentColor,
                  ),
                  onRefresh: () {
                    model.requestRecommendData();
                  },
                  loadMore: () {
                    model.requestRecommendData(loadMore: true);
                  },
                  autoLoad: true,
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: <Widget>[
                      SliverPersistentHeader(
                        floating: true,
                        delegate: _SliverSearchDelegate(
                            maxHeight: 55,
                            child: _SearchWidget(model.searchPlaceholder, 55)),
                      ),
                      SliverToBoxAdapter(
                        child: new _ShortcutsWidget(model.shortcutsData),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return MessageItem(
                            model.recommendData[index],
                            needMarginTop:
                                (model.recommendData[max(0, index - 1)].type ==
                                    'RECOMMENDED_MESSAGE'),
                          );
                        }, childCount: model.recommendData.length),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SearchWidget extends StatelessWidget {
  final SearchPlaceholder searchPlaceholder;
  final double height;

  const _SearchWidget(
    this.searchPlaceholder,
    this.height, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      /// 我艹，固定了宽度才可以。。。迷
      width: MediaQuery.of(context).size.width,
      height: height,
      color: AppColors.accentColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: AppDimensions.primaryPadding,
                  vertical: AppDimensions.primaryPadding - 2),
              padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.primaryPadding),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Row(
                  children: <Widget>[
                    Image.asset("images/ic_navbar_search.png"),
                    SizedBox(
                      width: AppDimensions.primaryPadding,
                    ),
                    Text(
                      searchPlaceholder.homeTab,
                      style: TextStyle(
                          color: AppColors.tipsTextColor, fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DebugPage();
                }));
              },
              child: Image.asset("images/ic_navbar_scan.png")),
          SizedBox(
            width: AppDimensions.primaryPadding,
          )
        ],
      ),
    );
  }
}

class _ShortcutsWidget extends StatelessWidget {
  final ShortcutsData shortcutsData;

  _ShortcutsWidget(this.shortcutsData);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (shortcutsData == null) return SizedBox();

        double imageSize = 55;

        List<Widget> headWidgetList =
            shortcutsData.shortcuts.map<Widget>((headItem) {
          Widget contentWidget;
          if (headItem.style == 'YELLOW') {
            contentWidget = Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.yellow, width: 3),
                  borderRadius: BorderRadius.circular(10)),
              child: AppNetWorkImage(
                src: headItem.picUrl,
                width: imageSize,
                height: imageSize,
                borderRadius: BorderRadius.circular(6),
              ),
            );
          } else if (headItem.style == 'DOTTED') {
            contentWidget = DottedBorder(
              child: AppNetWorkImage(
                src: headItem.picUrl,
                width: imageSize,
                height: imageSize,
                borderRadius: BorderRadius.circular(6),
              ),
              color: AppColors.dividerGrey,
              padding: EdgeInsets.all(2),
              strokeWidth: 3,
            );
          } else if (headItem.style == 'GRAY') {
            contentWidget = Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.dividerGrey, width: 3),
                  borderRadius: BorderRadius.circular(10)),
              child: AppNetWorkImage(
                src: headItem.picUrl,
                width: imageSize,
                height: imageSize,
                borderRadius: BorderRadius.circular(6),
              ),
            );
          }

          return Container(
            height: 105,
            margin: EdgeInsets.only(
                right: AppDimensions.smallPadding,
                left: (shortcutsData.shortcuts.indexOf(headItem) == 0
                    ? AppDimensions.primaryPadding
                    : 0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                contentWidget,
                SizedBox(
                  height: AppDimensions.primaryPadding,
                ),
                SizedBox(
                  width: 75,
                  child: Center(
                    child: Text(
                      headItem.content,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
              ],
            ),
          );
        }).toList();

        return Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: AppDimensions.smallPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.primaryPadding),
                child: Text(
                  shortcutsData.title,
                  style: TextStyle(
                    color: AppColors.primaryTextColor,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(
                height: AppDimensions.primaryPadding,
              ),
              LimitedBox(
                maxHeight: 105,
                child: ListView(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  children: headWidgetList,
                ),
              ),
            ],
          ),
        );
      },
    );
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
    return Stack(
      children: <Widget>[
        Positioned(
          top: -shrinkOffset,
          child: child,
        )
      ],
    );
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
