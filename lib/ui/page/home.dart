import 'package:today/ui/ui_base.dart';
import 'package:today/ui/page/debug.dart';
import 'package:today/ui/message.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:today/data/repository/recommend_model.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';
import 'package:dotted_border/dotted_border.dart';

class HomePage extends StatefulWidget {
  @override
  State createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomePage> {
  RecommendModel _recommendModel = RecommendModel();

  @override
  Widget build(BuildContext context) {
    return NormalPage(
      needAppBar: false,
      body: ScopedModel(
        child: _HomeBody(),
        model: _recommendModel,
      ),
    );
  }
}

class _HomeBody extends StatefulWidget {
  @override
  __HomeBodyState createState() => __HomeBodyState();
}

class __HomeBodyState extends State<_HomeBody>
    with AfterLayoutMixin<_HomeBody>, WidgetsBindingObserver {
  StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _subscription = Global.eventBus.on<RefreshTokenEvent>().listen((event) {
      afterFirstLayout(context);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _subscription?.cancel();
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
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        Future.delayed(Duration(milliseconds: 300), () {
          Fluttertoast.showToast(
              msg: model.recommendFee.toastMessage,
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: AppColors.accentColor,
              textColor: AppColors.primaryTextColor,
              gravity: ToastGravity.TOP,
              fontSize: 14);
        });

        return Column(
          children: <Widget>[
            Container(
              color: Color(0xffffe411),
              height: MediaQuery.of(context).padding.top,
            ),
            Expanded(
              child: EasyRefresh(
                firstRefresh: false,
                refreshHeader: PhoenixHeader(
                  key: GlobalKey(),
                ),
                onRefresh: () {
                  model.requestRecommendData();
                },
                child: CustomScrollView(
                  slivers: <Widget>[
                    new _SearchWidget(model.searchPlaceholder),
                    SliverToBoxAdapter(
                      child: new _ShortcutsWidget(model.shortcutsData),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return MessageItem(model.recommendData[index]);
                      }, childCount: model.recommendData.length),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    RecommendModel.of(context).requestRecommendData();
  }
}

class _SearchWidget extends StatelessWidget {
  final SearchPlaceholder searchPlaceholder;

  const _SearchWidget(
    this.searchPlaceholder, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
        floating: true,
        delegate: _SliverSearchDelegate(
            maxHeight: 60,
            child: Container(
              /// 我艹，固定了宽度才可以。。。迷
              width: MediaQuery.of(context).size.width,
              height: 60,
              color: Color(0xffffe411),
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
                                hintText: searchPlaceholder.homeTab,
                                prefixIcon:
                                    Image.asset("images/ic_navbar_search.png"),
                                hintStyle: TextStyle(fontSize: 14))),
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
                      child: Image.asset("images/ic_navbar_scan.png")),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
            )));
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

        List<Widget> headWidgetList =
            shortcutsData.shortcuts.map<Widget>((headItem) {
          Widget contentWidget;
          if (headItem.style == 'YELLOW') {
            contentWidget = Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.yellow, width: 3),
                  borderRadius: BorderRadius.circular(10)),
              child: AppNetWorkImage(
                src: headItem.picUrl,
                width: 60,
                height: 60,
                borderRadius: BorderRadius.circular(6),
              ),
            );
          } else if (headItem.style == 'DOTTED') {
            contentWidget = DottedBorder(
              child: AppNetWorkImage(
                src: headItem.picUrl,
                width: 60,
                height: 60,
                borderRadius: BorderRadius.circular(6),
              ),
              color: AppColors.dividerGrey,
              padding: EdgeInsets.all(3),
              strokeWidth: 3,
            );
          } else if (headItem.style == 'GRAY') {
            contentWidget = Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.dividerGrey, width: 3),
                  borderRadius: BorderRadius.circular(10)),
              child: AppNetWorkImage(
                src: headItem.picUrl,
                width: 60,
                height: 60,
                borderRadius: BorderRadius.circular(6),
              ),
            );
          }

          return Container(
            height: 110,
            margin: EdgeInsets.only(
                right: AppDimensions.primaryPadding,
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
          margin: EdgeInsets.only(bottom: AppDimensions.primaryPadding),
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
                      color: AppColors.primaryTextColor, fontSize: 16),
                ),
              ),
              SizedBox(
                height: AppDimensions.primaryPadding,
              ),
              LimitedBox(
                maxHeight: 110,
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
