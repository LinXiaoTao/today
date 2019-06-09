import 'package:today/ui/ui_base.dart';
import 'dart:ui' as ui show Image, ImageFilter;
import 'package:intl/intl.dart' as intl;

class PersonalDetailPage extends StatefulWidget {
  final String username;

  PersonalDetailPage({this.username = ''});

  @override
  _PersonalDetailPageState createState() => _PersonalDetailPageState();
}

class _PersonalDetailPageState extends State<PersonalDetailPage> {
  final PersonalDetailBloc _personalDetailBloc = PersonalDetailBloc();
  final PersonalUpdateBloc _personalActivityBloc = PersonalUpdateBloc();
  final StreamController<int> _pageController = StreamController();
  Stream<int> _pageStream;

  @override
  void dispose() {
    _pageController.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pageStream = _pageController.stream.asBroadcastStream();
  }

  @override
  Widget build(BuildContext context) {
    return NormalPage(
      body: DefaultTabController(
        length: 2,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
                pinned: true,
                floating: false,
                delegate: _SliverHeaderDelegate(
                    _personalDetailBloc, widget.username, _pageController)),
            SliverToBoxAdapter(
              child: Transform.translate(
                offset: Offset(0, -AppDimensions.primaryPadding),
                child: _TabContentWidget(
                  _personalActivityBloc,
                  _personalDetailBloc,
                  username: widget.username,
                  pageStream: _pageStream,
                ),
              ),
            ),
          ],
        ),
      ),
      needAppBar: false,
    );
  }
}

class _SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final PersonalDetailBloc bloc;
  final String username;
  final StreamController<int> pageController;

  _SliverHeaderDelegate(this.bloc, this.username, this.pageController);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    debugPrint('shrinkOffset = $shrinkOffset');
    return Stack(
      children: [
        Positioned(
          top: -shrinkOffset,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _PersonalInfoWidget(
                  bloc,
                  username: username,
                ),
                Transform.translate(
                    offset: Offset(0, -AppDimensions.primaryPadding),
                    child: _TabWidget(pageController)),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
                left: AppDimensions.primaryPadding,
                right: AppDimensions.primaryPadding),
            child: SizedBox(
              height: kToolbarHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  Image.asset(
                    'images/ic_messages_more.png',
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => (500 + 42.2);

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
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
    with AfterLayoutMixin<_PersonalInfoWidget> {
  @override
  void afterFirstLayout(BuildContext context) {
    widget.bloc.dispatch(FetchPersonalDataEvent(widget.username));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: widget.bloc,
        builder: (_, PersonalDetailState state) {
          if (state is LoadedPersonalDataState) {
            final userProfile = state.userInfo;
            UserInfo userInfo = userProfile.user;

            return SizedBox(
              height: 500,
              child: Stack(
                children: <Widget>[
                  Builder(builder: (_) {
                    if (userInfo.backgroundImage == null) {
                      return AppNetWorkImage(
                        colorFilter: ColorFilter.mode(
                            Colors.grey[400], BlendMode.multiply),
                        src: userInfo.avatarImage.picUrl,
                      );
                    }
                    return AppNetWorkImage(
                        colorFilter:
                            ColorFilter.mode(Colors.grey, BlendMode.multiply),
                        src: userInfo.backgroundImage.picUrl);
                  }),
                  Padding(
                    padding: EdgeInsets.only(
                        left: AppDimensions.primaryPadding,
                        right: AppDimensions.primaryPadding,
                        top: MediaQuery.of(context).padding.top),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: AppDimensions.primaryPadding * 1.5 +
                              kToolbarHeight,
                        ),
                        Row(
                          children: <Widget>[
                            AppNetWorkImage(
                              src: userInfo.avatarImage.thumbnailUrl,
                              width: 76,
                              height: 76,
                              borderRadius: BorderRadius.circular(76 / 2),
                            ),
                            Spacer(),
                            Container(
                              width: 85,
                              height: 35,
                              decoration: BoxDecoration(
                                  color: Color(0x8AD6D6D6),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(
                                      'images/ic_personal_page_chat.png',
                                      width: 16,
                                      height: 16,
                                    ),
                                    SizedBox(
                                      width: AppDimensions.smallPadding,
                                    ),
                                    Text(
                                      '聊天',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
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
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(
                                      'images/ic_common_subscribe_follow.png',
                                      width: 12,
                                      height: 12,
                                    ),
                                    SizedBox(
                                      width: AppDimensions.smallPadding,
                                    ),
                                    Text(
                                      '关注',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: AppDimensions.primaryPadding,
                        ),
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
                                  height: AppDimensions.primaryPadding,
                                ),
                                Row(
                                  children: <Widget>[
                                    Image.asset(
                                        'images/ic_common_verified.png'),
                                    SizedBox(
                                      width: AppDimensions.smallPadding,
                                    ),
                                    Text(
                                      userInfo.verifyMessage,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 13),
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
                                  horizontal: AppDimensions.smallPadding),
                              decoration: BoxDecoration(
                                  color: Color(0x8AD6D6D6),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Builder(builder: (_) {
                                    if (item.picUrl.isEmpty) return SizedBox();
                                    return AppNetWorkImage(
                                      src: item.picUrl,
                                      width: 12,
                                      height: 12,
                                    );
                                  }),
                                  Builder(builder: (_) {
                                    if (item.text.isEmpty ||
                                        item.picUrl.isEmpty) return SizedBox();
                                    return SizedBox(
                                      width: AppDimensions.smallPadding / 2,
                                    );
                                  }),
                                  Builder(builder: (_) {
                                    if (item.text.isEmpty) return SizedBox();
                                    return Text(
                                      item.text,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 11),
                                    );
                                  }),
                                ],
                              ),
                            );
                          }).toList();

                          return Column(
                            children: <Widget>[
                              SizedBox(
                                height: AppDimensions.primaryPadding * 0.8,
                              ),
                              Wrap(
                                children: children,
                                spacing: AppDimensions.smallPadding,
                                runSpacing: AppDimensions.smallPadding,
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
                                height: AppDimensions.primaryPadding,
                              ),
                              Text(
                                userProfile.relationMessage,
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 12),
                              ),
                            ],
                          );
                        }),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            _createCountWidget(
                                userInfo.statsCount.topicCreated, '创建的圈子'),
                            _createCountWidget(
                                userInfo.statsCount.topicSubscribed, '加入的圈子'),
                            _createCountWidget(
                                userInfo.statsCount.followingCount,
                                '${userInfo.genderText}关注的人'),
                            _createCountWidget(
                                userInfo.statsCount.followedCount,
                                '关注${userInfo.genderText}的人'),
                          ],
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
              height: 100, child: Center(child: PageLoadingWidget()));
        });
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

class _TabWidget extends StatelessWidget {
  final StreamController<int> pageController;

  _TabWidget(this.pageController) {
    this.pageController.sink.add(0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          height: 42,
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
            onTap: (index) {
              pageController.sink.add(index);
            },
          ),
        ),
        Divider(
          height: 0.2,
          color: AppColors.dividerGrey,
        ),
      ],
    );
  }
}

class _TabContentWidget extends StatefulWidget {
  final PersonalUpdateBloc bloc;
  final PersonalDetailBloc personalDetailBloc;
  final String username;
  final Stream<int> pageStream;

  _TabContentWidget(this.bloc, this.personalDetailBloc,
      {this.username = '', @required this.pageStream});

  @override
  _TabContentWidgetState createState() => _TabContentWidgetState();
}

class _TabContentWidgetState extends State<_TabContentWidget>
    with AfterLayoutMixin<_TabContentWidget> {
  @override
  void afterFirstLayout(BuildContext context) {
    widget.bloc.dispatch(FetchPersonalUpdateEvent(widget.username));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.pageStream,
        builder: (_, snapshot) {
          int index = 0;
          if (snapshot.hasData) {
            index = snapshot.data;
          }

          return WrapStack(
            children: <Widget>[
              WrapStackChild(
                warp: index == 1,
                child: Opacity(
                  opacity: (index == 0 ? 1 : 0),
                  child: _TabActivityWidget(
                    bloc: widget.bloc,
                  ),
                ),
              ),
              WrapStackChild(
                warp: index == 0,
                child: Opacity(
                    opacity: (index == 1 ? 1 : 0),
                    child: _TabInformationWidget(widget.personalDetailBloc)),
              ),
            ],
          );
        });
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

  _TabActivityWidget({
    Key key,
    @required this.bloc,
  }) : super(key: key);

  final intl.DateFormat _dateFormat = intl.DateFormat('MM/dd HH:mm');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: bloc,
        builder: (_, PersonalUpdateState state) {
          if (state is LoadedPersonalActivityState) {
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.primaryPadding,
              ),
              color: Colors.white,
              child: ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: state.items.length,
                padding: EdgeInsets.zero,
                itemBuilder: (_, index) {
                  Message item = state.items[index];

                  return Padding(
                    padding: EdgeInsets.only(
                        top: AppDimensions.primaryPadding * 2,
                        bottom: AppDimensions.smallPadding),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AvatarWidget(
                          item.user,
                        ),
                        SizedBox(
                          width: AppDimensions.smallPadding,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 40,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    ScreenNameWidget(
                                      user: item.user,
                                    ),
                                    Text(
                                      _dateFormat.format(
                                          DateTime.parse(item.createdAt)
                                              .toLocal()),
                                      style: TextStyle(
                                          color: AppColors.tipsTextColor,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: AppDimensions.smallPadding,
                              ),
                              RichTextWidget(item),
                              MessageBodyWidget(item),
                              Builder(builder: (_) {
                                if (item.topic == null) return SizedBox();

                                return Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: AppDimensions.primaryPadding,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      padding: EdgeInsets.symmetric(
                                          vertical: AppDimensions.smallPadding /
                                              3 *
                                              2,
                                          horizontal:
                                              AppDimensions.primaryPadding /
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
                                            width: AppDimensions.smallPadding,
                                          ),
                                          Text(
                                            item.topic.content,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: AppColors.blue),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              }),
                              SizedBox(
                                height: AppDimensions.primaryPadding,
                              ),
                              CommentWidget(
                                bodyItem: item,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (_, index) {
                  return Padding(
                    padding:
                        EdgeInsets.only(left: AppDimensions.primaryPadding),
                    child: Divider(
                      color: AppColors.dividerGrey,
                    ),
                  );
                },
              ),
            );
          }

          return PageLoadingWidget();
        });
  }
}
