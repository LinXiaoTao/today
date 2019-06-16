import 'package:today/ui/ui_base.dart';
import 'dart:ui' as ui show Image, ImageFilter;
import 'package:intl/intl.dart' as intl;
import 'package:today/ui/page/picture_detail.dart';

final _tabHeight = 45.0;
final _tabDivider = 0.2;
final _headerHeight = 480.0;

class PersonalDetailPage extends StatefulWidget {
  final String username;

  PersonalDetailPage({this.username = ''});

  @override
  _PersonalDetailPageState createState() => _PersonalDetailPageState();
}

class _PersonalDetailPageState extends State<PersonalDetailPage> {
  final PersonalDetailBloc _personalDetailBloc = PersonalDetailBloc();
  final PersonalUpdateBloc _personalActivityBloc = PersonalUpdateBloc();

  @override
  void dispose() {
    _personalDetailBloc?.dispose();
    _personalActivityBloc?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NormalPage(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                child: SliverAppBar(
                  elevation: 0,
                  pinned: true,
                  forceElevated: innerBoxIsScrolled,
                  backgroundColor: Colors.transparent,
                  expandedHeight: (_headerHeight),
                  iconTheme: IconThemeData(color: Colors.white),
                  actions: <Widget>[
                    Image.asset(
                      'images/ic_messages_more.png',
                      color: Colors.white,
                    )
                  ],
                  titleSpacing: 0,
                  title: _AppBarTitleWidget(_personalDetailBloc),
                  bottom: _TabWidget(),
                  flexibleSpace: _PersonalInfoWidget(
                    _personalDetailBloc,
                    username: widget.username,
                  ),
                ),
              )
            ];
          },
          body: _TabContentWidget(
            _personalActivityBloc,
            _personalDetailBloc,
            username: widget.username,
          ),
        ),
      ),
      needAppBar: false,
    );
  }
}

class _AppBarTitleWidget extends StatefulWidget {
  final PersonalDetailBloc bloc;

  _AppBarTitleWidget(this.bloc);

  @override
  State<StatefulWidget> createState() {
    return _AppBarTitleState();
  }
}

class _AppBarTitleState extends State<_AppBarTitleWidget>
    with SingleTickerProviderStateMixin<_AppBarTitleWidget> {
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;
  bool _show = false;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _offsetAnimation =
        Tween(begin: Offset(0, kToolbarHeight), end: Offset(0, 0))
            .animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FlexibleSpaceBarSettings settings =
        context.inheritFromWidgetOfExactType(FlexibleSpaceBarSettings);

    /// 允许 0.1 的误差
    if (settings.currentExtent > (settings.minExtent + 0.1)) {
      _show = false;
      return SizedBox();
    }

    if (!_show) {
      _show = true;
      _controller.reset();
      _controller.forward();
    }

    return AnimatedBuilder(
      animation: _offsetAnimation,
      builder: (_, child) {
        return Transform.translate(
          offset: _offsetAnimation.value,
          child: child,
        );
      },
      child: BlocBuilder(
        bloc: widget.bloc,
        builder: (_, state) {
          if (state is LoadedPersonalDataState) {
            if (state.userInfo == null) return SizedBox();

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      AvatarWidget(
                        state.userInfo.user,
                        jumpDetail: false,
                        size: 36,
                      ),
                      SizedBox(
                        width: AppDimensions.primaryPadding,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 36,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              ScreenNameWidget(
                                user: state.userInfo.user,
                                textColor: Colors.white,
                                fontSize: 12,
                                showVerify: false,
                              ),
                              Text(
                                '${state.userInfo.user.statsCount.followedCount}人关注',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 60,
                  height: 28,
                  decoration: BoxDecoration(
                      color: AppColors.blue,
                      borderRadius: BorderRadius.circular(18)),
                  child: Center(
                    child: Text(
                      '关注',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
              ],
            );
          }

          return SizedBox();
        },
      ),
    );
  }
}

class _PersonalInfoWidget extends StatefulWidget {
  final PersonalDetailBloc bloc;
  final String username;

  _PersonalInfoWidget(this.bloc, {this.username});

  @override
  __PersonalInfoWidgetState createState() => __PersonalInfoWidgetState();
}

class __PersonalInfoWidgetState extends State<_PersonalInfoWidget>
    with
        AfterLayoutMixin<_PersonalInfoWidget>,
        SingleTickerProviderStateMixin<_PersonalInfoWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    widget.bloc.dispatch(FetchPersonalDataEvent(widget.username));
  }

  @override
  Widget build(BuildContext context) {
    final FlexibleSpaceBarSettings settings =
        context.inheritFromWidgetOfExactType(FlexibleSpaceBarSettings);

    double scale = (settings.currentExtent - settings.minExtent) /
        (settings.maxExtent - settings.minExtent);

    return Stack(
      children: [
        Positioned(
            top: settings.currentExtent - settings.maxExtent,
            child: BlocBuilder(
                bloc: widget.bloc,
                builder: (_, PersonalDetailState state) {
                  if (state is LoadedPersonalDataState) {
                    final userProfile = state.userInfo;

                    if (userProfile == null) return SizedBox();

                    UserInfo userInfo = userProfile.user;

                    return SizedBox(
                      height: settings.maxExtent,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: <Widget>[
                          LayoutBuilder(builder: (_, layout) {
                            if (userInfo.backgroundImage == null) {
                              return AppNetWorkImage(
                                colorFilter: ColorFilter.mode(
                                    Colors.grey[400], BlendMode.multiply),
                                src: userInfo.avatarImage.picUrl,
                              );
                            }
                            return AppNetWorkImage(
                                colorFilter: ColorFilter.mode(
                                    Colors.grey, BlendMode.multiply),
                                src: userInfo.backgroundImage.picUrl);
                          }),
                          Padding(
                            padding: EdgeInsets.only(
                              left: AppDimensions.primaryPadding,
                              right: AppDimensions.primaryPadding,
                              top: AppDimensions.primaryPadding * 2,
                              bottom: _tabDivider + _tabHeight,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: AppDimensions.primaryPadding * 1.5 +
                                      kToolbarHeight,
                                ),
                                Opacity(
                                  opacity: (scale == 1
                                      ? 1
                                      : max(
                                          0,
                                          ((scale / 3) < 0.22
                                              ? 0
                                              : scale / 3))),
                                  child: Row(
                                    children: <Widget>[
                                      AppNetWorkImage(
                                        src: userInfo.avatarImage.thumbnailUrl,
                                        width: 76,
                                        height: 76,
                                        borderRadius:
                                            BorderRadius.circular(76 / 2),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: 85,
                                        height: 35,
                                        decoration: BoxDecoration(
                                            color: Color(0x8AD6D6D6),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Image.asset(
                                                'images/ic_personal_page_chat.png',
                                                width: 16,
                                                height: 16,
                                              ),
                                              SizedBox(
                                                width:
                                                    AppDimensions.smallPadding,
                                              ),
                                              Text(
                                                '聊天',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: AppDimensions.primaryPadding,
                                      ),
                                      Container(
                                        width: 85,
                                        height: 35,
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Image.asset(
                                                'images/ic_common_subscribe_follow.png',
                                                width: 12,
                                                height: 12,
                                              ),
                                              SizedBox(
                                                width:
                                                    AppDimensions.smallPadding,
                                              ),
                                              Text(
                                                '关注',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: AppDimensions.primaryPadding,
                                ),
                                Opacity(
                                  opacity: (scale == 1
                                      ? 1
                                      : max(0,
                                          ((scale / 2) < 0.2 ? 0 : scale / 2))),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      ScreenNameWidget(
                                        user: userInfo,
                                        textColor: Colors.white,
                                        fontSize: 17,
                                      ),
                                      Builder(builder: (_) {
                                        if (userInfo.isVerified) {
                                          return Column(
                                            children: <Widget>[
                                              SizedBox(
                                                height: AppDimensions
                                                    .primaryPadding,
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Image.asset(
                                                      'images/ic_common_verified.png'),
                                                  SizedBox(
                                                    width: AppDimensions
                                                        .smallPadding,
                                                  ),
                                                  Text(
                                                    userInfo.verifyMessage,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        }
                                        return SizedBox();
                                      }),
                                      SizedBox(
                                        height: AppDimensions.primaryPadding,
                                      ),
                                      Text(
                                        userInfo.bio,
                                        maxLines: 6,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Builder(builder: (_) {
                                        /// 各种标签
                                        if (userInfo.profileTags.isEmpty) {
                                          return SizedBox();
                                        }

                                        List<Widget> children =
                                            userInfo.profileTags.map((item) {
                                          return Container(
                                            height: 18,
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    AppDimensions.smallPadding),
                                            decoration: BoxDecoration(
                                                color: Color(0x8AD6D6D6),
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Builder(builder: (_) {
                                                  if (item.picUrl.isEmpty)
                                                    return SizedBox();
                                                  return AppNetWorkImage(
                                                    src: item.picUrl,
                                                    width: 12,
                                                    height: 12,
                                                  );
                                                }),
                                                Builder(builder: (_) {
                                                  if (item.text.isEmpty ||
                                                      item.picUrl.isEmpty)
                                                    return SizedBox();
                                                  return SizedBox(
                                                    width: AppDimensions
                                                            .smallPadding /
                                                        2,
                                                  );
                                                }),
                                                Builder(builder: (_) {
                                                  if (item.text.isEmpty)
                                                    return SizedBox();
                                                  return Text(
                                                    item.text,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 11),
                                                  );
                                                }),
                                              ],
                                            ),
                                          );
                                        }).toList();

                                        return Column(
                                          children: <Widget>[
                                            SizedBox(
                                              height:
                                                  AppDimensions.primaryPadding *
                                                      0.8,
                                            ),
                                            Wrap(
                                              children: children,
                                              spacing:
                                                  AppDimensions.smallPadding,
                                              runSpacing:
                                                  AppDimensions.smallPadding,
                                            ),
                                          ],
                                        );
                                      }),
                                      Builder(builder: (_) {
                                        if (userProfile.relationMessage.isEmpty)
                                          return SizedBox();

                                        return Column(
                                          children: <Widget>[
                                            SizedBox(
                                              height:
                                                  AppDimensions.primaryPadding,
                                            ),
                                            Text(
                                              userProfile.relationMessage,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Opacity(
                                  opacity: (scale == 1 ? 1 : max(0, scale)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      _createCountWidget(
                                          userInfo.statsCount.topicCreated,
                                          '创建的圈子'),
                                      _createCountWidget(
                                          userInfo.statsCount.topicSubscribed,
                                          '加入的圈子'),
                                      _createCountWidget(
                                          userInfo.statsCount.followingCount,
                                          '${userInfo.genderText}关注的人'),
                                      _createCountWidget(
                                          userInfo.statsCount.followedCount,
                                          '关注${userInfo.genderText}的人'),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: AppDimensions.primaryPadding * 2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: settings.maxExtent,
                      child: Center(child: PageLoadingWidget()));
                })),
      ],
    );
  }

  _createCountWidget(int count, String title) {
    return Column(
      children: <Widget>[
        Text(
          '$count',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 24),
        ),
        SizedBox(
          height: AppDimensions.smallPadding,
        ),
        Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}

class _TabWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          height: _tabHeight,
          child: TabBar(
            tabs: [
              Tab(
                text: '动态',
              ),
              Tab(
                text: '档案',
              ),
            ],
            indicatorColor: AppColors.blue,
            indicatorWeight: 3,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: AppColors.blue,
            labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            unselectedLabelColor: AppColors.normalTextColor,
            unselectedLabelStyle:
                TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        Divider(
          height: _tabDivider,
          color: AppColors.dividerGrey,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_tabHeight + _tabDivider);
}

class _TabContentWidget extends StatefulWidget {
  final PersonalUpdateBloc bloc;
  final PersonalDetailBloc personalDetailBloc;
  final String username;

  _TabContentWidget(
    this.bloc,
    this.personalDetailBloc, {
    this.username = '',
  });

  @override
  _TabContentWidgetState createState() => _TabContentWidgetState();
}

class _TabContentWidgetState extends State<_TabContentWidget>
    with AfterLayoutMixin<_TabContentWidget> {
  bool _loadMore = false;

  @override
  void initState() {
    widget.bloc.state.listen((state) {
      if (state is LoadedPersonalActivityState) {
        /// 加载成功
        _loadMore = false;
      }
      debugPrint('state = $state');
    });
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    widget.bloc.dispatch(FetchPersonalUpdateEvent(widget.username));
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(children: [
      NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          /// 自动加载更多
          if (notification is ScrollEndNotification &&
              notification.metrics != null) {
            if (notification.metrics.extentAfter < 200 &&
                notification.metrics.extentInside > 0 &&
                !_loadMore) {
              /// 加载更多
              _loadMore = true;
              widget.bloc.dispatch(
                  FetchPersonalUpdateEvent(widget.username, loadMore: true));
            }
          }
        },
        child: CustomScrollView(
          slivers: <Widget>[
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            SliverToBoxAdapter(
              child: _TabActivityWidget(
                bloc: widget.bloc,
                detailBloc: widget.personalDetailBloc,
              ),
            )
          ],
        ),
      ),
      CustomScrollView(
        slivers: <Widget>[
          SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
          SliverToBoxAdapter(
            child: _TabInformationWidget(widget.personalDetailBloc),
          ),
        ],
      ),
    ]);
  }
}

class _TabInformationWidget extends StatelessWidget {
  final PersonalDetailBloc personalDetailBloc;

  _TabInformationWidget(this.personalDetailBloc);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: personalDetailBloc,
        builder: (_, PersonalDetailState state) {
          /// 档案
          if (state is LoadedPersonalDataState) {
            final user = state.userInfo.user;
            return Column(
              children: <Widget>[
                Builder(builder: (_) {
                  /// 徽章
                  if (user.medals.isNotEmpty) {
                    List<Widget> children = [];
                    children.addAll(user.medals
                        .sublist(0, min(4, user.medals.length))
                        .map((item) {
                      return Padding(
                        padding: EdgeInsets.only(
                            right: AppDimensions.primaryPadding),
                        child: AppNetWorkImage(
                          width: 45,
                          height: 45,
                          src: item.picUrl,
                          borderRadius: BorderRadius.zero,
                        ),
                      );
                    }).toList());

                    children.add(Spacer());

                    if (user.medals.length > 4) {
                      children.add(Container(
                        padding: EdgeInsets.symmetric(
                            vertical: AppDimensions.smallPadding * 0.8,
                            horizontal: AppDimensions.primaryPadding * 1.5),
                        decoration: BoxDecoration(
                            color: AppColors.darkGrey,
                            borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          '${user.medals.length}',
                          style: TextStyle(
                              color: AppColors.tipsTextColor, fontSize: 12),
                        ),
                      ));
                      children.add(SizedBox(
                        width: AppDimensions.primaryPadding,
                      ));
                    }

                    children
                        .add(Image.asset('images/ic_common_arrow_right.png'));

                    return Column(
                      children: <Widget>[
                        _createTitleWidget(
                            '徽章', 'images/ic_personal_page_badge.png'),
                        _createContentPadding(Row(
                          children: children,
                        )),
                      ],
                    );
                  }

                  return SizedBox();
                }),
                Builder(builder: (_) {
                  /// 基本信息
                  List<Widget> children = [];
                  if (user.gender.isNotEmpty) {
                    /// 性别
                    children
                        .add(_createInformationWidget('性别', user.genderType));
                  }

                  if (user.zodiac.isNotEmpty) {
                    /// 星座
                    children.add(_createInformationWidget('星座', user.zodiac));
                  }

                  if (user.province.isNotEmpty) {
                    /// 所在地
                    children.add(_createInformationWidget(
                        '所在地', '${user.province}-${user.city}'));
                  }

                  if (children.isEmpty) return SizedBox();

                  if (children.length == 2) {
                    children.insert(
                        1,
                        SizedBox(
                          height: AppDimensions.primaryPadding,
                        ));
                  } else if (children.length == 3) {
                    children.insert(
                        1,
                        SizedBox(
                          height: AppDimensions.primaryPadding,
                        ));
                    children.insert(
                        3,
                        SizedBox(
                          height: AppDimensions.primaryPadding,
                        ));
                  }

                  return Column(
                    children: <Widget>[
                      _createTitleWidget('基本信息',
                          'images/ic_personal_page_basic_information.png'),
                      _createContentPadding(Column(
                        children: children,
                      )),
                    ],
                  );
                }),
                Builder(builder: (_) {
                  if (user.industry.isEmpty) return SizedBox();

                  /// 行业
                  return Column(
                    children: <Widget>[
                      _createTitleWidget(
                          '行业', 'images/ic_personal_page_career.png'),
                      _createContentPadding(Text(
                        '${user.industry}',
                        style: TextStyle(
                            fontSize: 12, color: AppColors.normalTextColor),
                      )),
                    ],
                  );
                }),
                Builder(builder: (_) {
                  return Column(
                    children: <Widget>[
                      _createTitleWidget(
                          '签名', 'images/ic_personal_page_self_description.png'),
                      _createContentPadding(Text(
                        '${user.bio}',
                        style: TextStyle(
                            fontSize: 12, color: AppColors.normalTextColor),
                      ))
                    ],
                  );
                }),
              ],
            );
          }

          return PageLoadingWidget();
        });
  }

  _createContentPadding(Widget child) {
    return LayoutBuilder(
      builder: (_, layout) {
        return Container(
          width: layout.maxWidth,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.primaryPadding * 2 +
                    21 +
                    AppDimensions.primaryPadding,
                vertical: AppDimensions.primaryPadding),
            child: child,
          ),
        );
      },
    );
  }

  _createInformationWidget(String title, String value) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 80,
          child: Text(
            title,
            style: TextStyle(fontSize: 12, color: AppColors.primaryTextColor),
          ),
        ),
        Text(
          '$value',
          style: TextStyle(fontSize: 12, color: AppColors.normalTextColor),
        )
      ],
    );
  }

  _createTitleWidget(String title, String icon) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.primaryPadding * 2,
          vertical: AppDimensions.primaryPadding * 0.8),
      child: Row(
        children: <Widget>[
          Image.asset(
            icon,
            width: 21,
            height: 21,
          ),
          SizedBox(
            width: AppDimensions.primaryPadding,
          ),
          Text(
            title,
            style: TextStyle(
                color: AppColors.primaryTextColor,
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _TabActivityWidget extends StatelessWidget {
  final PersonalUpdateBloc bloc;
  final PersonalDetailBloc detailBloc;

  _TabActivityWidget({Key key, @required this.bloc, @required this.detailBloc})
      : super(key: key);

  final intl.DateFormat _dateFormat = intl.DateFormat('MM/dd HH:mm');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        BlocBuilder(
          bloc: detailBloc,
          builder: (_, PersonalDetailState state) {
            if (state is LoadedPersonalDataState) {
              return DefaultTextStyle(
                style: TextStyle(fontSize: 12, color: AppColors.tipsTextColor),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.primaryPadding,
                      vertical: AppDimensions.smallPadding),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        'images/ic_messages_like_unselected.png',
                        width: 15,
                        height: 15,
                      ),
                      SizedBox(
                        width: AppDimensions.smallPadding,
                      ),
                      Text(
                        '动态获得 ${state.userInfo.user.statsCount.formatLiked} 次赞',
                      ),
                      SizedBox(
                        width: AppDimensions.primaryPadding * 2,
                      ),
                      Image.asset(
                        'images/ic_personal_page_choice_tag.png',
                        width: 15,
                        height: 15,
                      ),
                      SizedBox(
                        width: AppDimensions.smallPadding,
                      ),
                      Text(
                          '获得 ${state.userInfo.user.statsCount.formatHighlightedPersonalUpdates} 次精选'),
                    ],
                  ),
                ),
              );
            }
            return SizedBox();
          },
        ),
        BlocBuilder(
            bloc: bloc,
            builder: (_, PersonalUpdateState state) {
              if (state is LoadedPersonalActivityState) {
                return Container(
                  color: Colors.white,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.items.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (_, index) {
                      Message item = state.items[index];

                      return Material(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return MessageDetailPage(
                                id: item.id,
                                pageName: 'personal_page',
                                type: item.messageType,
                                userRef: item.user?.ref ?? '',
                                topicRef: item.topic?.ref ?? '',
                              );
                            }));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: AppDimensions.primaryPadding,
                                right: AppDimensions.primaryPadding,
                                top: AppDimensions.primaryPadding * 2,
                                bottom: AppDimensions.primaryPadding),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                AvatarWidget(
                                  item.user,
                                ),
                                SizedBox(
                                  width: AppDimensions.primaryPadding,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 40,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                ScreenNameWidget(
                                                  user: item.user,
                                                ),
                                                SizedBox(
                                                  width: AppDimensions
                                                          .smallPadding /
                                                      2,
                                                ),
                                                Builder(builder: (_) {
                                                  if (item.messageType ==
                                                      MessageType.RE_POST) {
                                                    return Text(
                                                      '分享了',
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .tipsTextColor),
                                                    );
                                                  }

                                                  if (item.messageType ==
                                                      MessageType.ANSWER) {
                                                    return Text(
                                                      '回答了问题',
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .tipsTextColor),
                                                    );
                                                  }

                                                  if (item.messageType ==
                                                      MessageType.QUESTION) {
                                                    return Text(
                                                      '提了问题',
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .tipsTextColor),
                                                    );
                                                  }

                                                  return SizedBox();
                                                }),
                                              ],
                                            ),
                                            Text(
                                              _dateFormat.format(
                                                  DateTime.parse(item.createdAt)
                                                      .toLocal()),
                                              style: TextStyle(
                                                  color:
                                                      AppColors.tipsTextColor,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: AppDimensions.smallPadding,
                                      ),
                                      Builder(builder: (_) {
                                        if (item.messageType ==
                                            MessageType.ANSWER) {
                                          return Column(
                                            children: <Widget>[
                                              AnswerWidget(item),
                                              SizedBox(
                                                height:
                                                    AppDimensions.smallPadding,
                                              ),
                                            ],
                                          );
                                        }

                                        final List<TextSpan> child = [];

                                        if (item.pictures.isNotEmpty &&
                                            item.messageType !=
                                                MessageType.ORIGINAL_POST) {
                                          TapGestureRecognizer detail =
                                              TapGestureRecognizer();
                                          detail.onTap = () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(builder: (_) {
                                              return PictureDetailPage(
                                                item.pictures,
                                              );
                                            }));
                                          };

                                          child.add(ImageSpan(
                                            AssetImage(
                                                'images/ic_feedback_sendpic.png'),
                                            imageWidth: 15,
                                            imageHeight: 15,
                                            color: AppColors.blue,
                                            margin: EdgeInsets.only(
                                                right:
                                                    AppDimensions.smallPadding /
                                                        2),
                                          ));

                                          child.add(TextSpan(
                                            text: '查看图片',
                                            style: TextStyle(
                                              color: AppColors.blue,
                                            ),
                                            recognizer: detail,
                                          ));
                                        }

                                        if (item.content.isNotEmpty) {
                                          child.addAll(parseUrlsInText(
                                              item.urlsInText,
                                              item.content,
                                              context));
                                        }

                                        if (child.isEmpty) {
                                          return SizedBox();
                                        }

                                        return Column(
                                          children: <Widget>[
                                            RealRichText(
                                              child,
                                              style: TextStyle(
                                                  color: AppColors
                                                      .primaryTextColor),
                                            ),
                                            SizedBox(
                                              height:
                                                  AppDimensions.smallPadding,
                                            ),
                                          ],
                                        );
                                      }),
                                      Builder(builder: (_) {
                                        if (item.messageType ==
                                            MessageType.ORIGINAL_POST) {
                                          return Column(
                                            children: <Widget>[
                                              MessageBodyWidget(item),
                                              SizedBox(
                                                height: AppDimensions
                                                    .primaryPadding,
                                              ),
                                            ],
                                          );
                                        }
                                        return SizedBox();
                                      }),
                                      Column(
                                        children: <Widget>[
                                          LinkInfoWidget(item),
                                          Builder(builder: (_) {
                                            if (item.linkInfo == null)
                                              return SizedBox();

                                            return SizedBox(
                                              height:
                                                  AppDimensions.primaryPadding,
                                            );
                                          }),
                                        ],
                                      ),
                                      Builder(builder: (_) {
                                        if (RePostWidget.hasData(item)) {
                                          return Column(
                                            children: <Widget>[
                                              RePostWidget(item),
                                              SizedBox(
                                                height: AppDimensions
                                                    .primaryPadding,
                                              ),
                                            ],
                                          );
                                        }
                                        return SizedBox();
                                      }),
                                      Builder(builder: (_) {
                                        if (item.topic == null)
                                          return SizedBox();

                                        /// 圈子信息
                                        return Column(
                                          children: <Widget>[
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: AppDimensions
                                                          .smallPadding /
                                                      3 *
                                                      2,
                                                  horizontal: AppDimensions
                                                          .primaryPadding /
                                                      3 *
                                                      2),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Image.asset(
                                                    'images/ic_personal_tab_my_topic.png',
                                                    width: 16,
                                                    height: 16,
                                                  ),
                                                  SizedBox(
                                                    width: AppDimensions
                                                        .smallPadding,
                                                  ),
                                                  Text(
                                                    item.topic.content,
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: AppColors.blue),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height:
                                                  AppDimensions.primaryPadding,
                                            ),
                                          ],
                                        );
                                      }),
                                      CommentWidget(
                                        bodyItem: item,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (_, index) {
                      return Divider(
                        indent: AppDimensions.primaryPadding,
                        height: 1,
                        color: AppColors.dividerGrey,
                      );
                    },
                  ),
                );
              }
              return PageLoadingWidget();
            }),
      ],
    );
  }
}
