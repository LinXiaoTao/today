import 'package:today/ui/page/topic/topic_list.dart';
import 'package:today/ui/ui_base.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:today/ui/page/debug.dart';
import 'package:today/widget/message.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomePage> with AfterLayoutMixin<HomePage> {
  final SearchPlaceholderBloc _searchPlaceholderBloc = SearchPlaceholderBloc();
  final ShortcutBloc _shortcutBloc = ShortcutBloc();
  RecommendBloc _recommendBloc;

  StreamSubscription _homeSubscription;

  ScrollController _scrollController = ScrollController();

  final GlobalKey<EasyRefreshState> _refreshKey = GlobalKey();

  final GlobalKey<PhoenixHeaderState> _refreshHeaderKey = GlobalKey();

  final GlobalKey<BallPulseFooterState> _loadMoreFooterKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _recommendBloc.add(FetchRecommendEvent());
    _shortcutBloc.add(FetchShortcutEvent());
    _searchPlaceholderBloc.add(FetchSearchPlaceHolderEvent());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _homeSubscription?.cancel();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _recommendBloc = BlocProvider.of(context);
    _recommendBloc.listen((event) {
      if (event is FetchRecommendEvent) {
        if (!(event as FetchRecommendEvent).loadMore) {
          _scrollController.animateTo(0,
              curve: Curves.fastLinearToSlowEaseIn,
              duration: Duration(milliseconds: 300));
        }
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchPlaceholderBloc>(
      create: (_) {
        return _searchPlaceholderBloc;
      },
      child: BlocProvider<ShortcutBloc>(
        create: (_) {
          return _shortcutBloc;
        },
        child: Column(
          children: <Widget>[
            Container(
              color: Color(0xffffe411),
              height: MediaQuery.of(context).padding.top,
            ),
            Expanded(
              child: NotificationListener<ScrollUpdateNotification>(
                onNotification: (notification) {
                  BlocProvider.of<NavigationBarBloc>(context).add(
                      SwitchHomeNavigationBarEvent(
                          refreshMode:
                              _scrollController.position.pixels > 2000));
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
                    _recommendBloc.add(FetchRecommendEvent());
                  },
                  loadMore: () {
                    _recommendBloc.add(FetchRecommendEvent(loadMore: true));
                  },
                  autoLoad: true,
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: <Widget>[
                      SliverPersistentHeader(
                        floating: true,
                        delegate: _SliverSearchDelegate(
                            maxHeight: 55,
                            child: _SearchWidget(55, _searchPlaceholderBloc)),
                      ),
                      SliverToBoxAdapter(
                        child: _ShortcutsWidget(_shortcutBloc),
                      ),
                      BlocListener(
                        bloc: _recommendBloc,
                        listener: (_, state) {
                          if (state is LoadedRecommendState) {
                            if (state.toastMsg.isEmpty) return;
                            Fluttertoast.showToast(
                                msg: state.toastMsg,
                                toastLength: Toast.LENGTH_LONG,
                                backgroundColor: AppColors.accentColor,
                                textColor: AppColors.primaryTextColor,
                                gravity: ToastGravity.TOP,
                                fontSize: 14);
                          }
                        },
                        child: BlocBuilder(
                            bloc: _recommendBloc,
                            builder: (_, RecommendState state) {
                              if (state is LoadedRecommendState) {
                                return SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                      (context, index) {
                                    return MessageItem(
                                      state.recommendList[index],
                                      needMarginTop: (_recommendBloc
                                              .recommendList[max(0, index - 1)]
                                              .type ==
                                          'RECOMMENDED_MESSAGE'),
                                    );
                                  }, childCount: state.recommendList.length),
                                );
                              }

                              return SliverToBoxAdapter(
                                child: PageLoadingWidget(),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchWidget extends StatelessWidget {
  final double height;
  final SearchPlaceholderBloc bloc;

  _SearchWidget(this.height, this.bloc);

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
                    BlocBuilder(
                      bloc: bloc,
                      builder: (_, SearchPlaceholderState state) {
                        return Text(
                          (state is LoadedSearchPlaceHolderState)
                              ? state.searchPlaceholder.homeTab
                              : '',
                          style: TextStyle(
                              color: AppColors.tipsTextColor, fontSize: 16),
                        );
                      },
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
  final ShortcutBloc bloc;
  final double imageSize = 55;

  _ShortcutsWidget(this.bloc);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: bloc,
      builder: (_, ShortcutState state) {
        if (state is LoadedShortcutState) {
          ShortcutsData shortcutsData = state.shortcutsData;

          List<Widget> headWidgetList =
              shortcutsData.shortcuts.map<Widget>((headItem) {
            Widget contentWidget;
            Widget tagWidget = SizedBox();

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

              if (headItem.tag.isNotEmpty) {
                tagWidget = Container(
                  width: 35,
                  padding: EdgeInsets.symmetric(vertical: 1),
                  decoration: BoxDecoration(
                      color: AppColors.yellow,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(child: Text(headItem.tag)),
                );
              }
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

              if (headItem.tag.isNotEmpty) {
                tagWidget = Container(
                  width: 50,
                  height: 30,
                  decoration: BoxDecoration(
                      color: AppColors.dividerGrey,
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(headItem.tag),
                );
                tagWidget = Container(
                  width: 35,
                  padding: EdgeInsets.symmetric(vertical: 1),
                  decoration: BoxDecoration(
                      color: AppColors.dividerGrey,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(child: Text(headItem.tag)),
                );
              }
            }

            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return BlocProvider(
                      create: (_) {
                        return bloc;
                      },
                      child: TopicListPage());
                }));
              },
              child: Container(
                height: 105,
                margin: EdgeInsets.only(
                    right: AppDimensions.smallPadding,
                    left: (shortcutsData.shortcuts.indexOf(headItem) == 0
                        ? AppDimensions.primaryPadding
                        : 0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.topLeft,
                      children: [contentWidget, tagWidget],
                    ),
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
        }

        return SizedBox();
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
