import 'package:today/ui/ui_base.dart';
import 'package:today/ui/page/main/home.dart';
import 'package:today/ui/page/main/activity.dart';
import 'package:today/ui/page/main/chat.dart';
import 'package:today/ui/page/main/mine.dart';

class MainPage extends StatefulWidget {
  @override
  State createState() {
    return _MainState();
  }
}

class _MainState extends State<MainPage> {
  List<Widget> _pages;

  TabBloc _tabBloc = TabBloc();
  NavigationBarBloc _navigationBarBloc;
  final RecommendBloc _recommendBloc = RecommendBloc();

  @override
  void initState() {
    _pages = [HomePage(), ActivityPage(), ChatPage(), MinePage()];
    _navigationBarBloc = NavigationBarBloc(_tabBloc);
    _navigationBarBloc.add(FetchNavigationBarEvent());
    super.initState();
  }

  @override
  void dispose() {
    _navigationBarBloc?.close();
    _recommendBloc?.close();
    _tabBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigationBarBloc>(
      create: (_) {
        return _navigationBarBloc;
      },
      child: BlocProvider<TabBloc>(
        create: (_) {
          return _tabBloc;
        },
        child: BlocProvider<RecommendBloc>(
          create: (_) {
            return _recommendBloc;
          },
          child: Scaffold(
            bottomNavigationBar: BlocBuilder(
                bloc: _navigationBarBloc,
                builder: (_, NavigationBarState state) {
                  if (state is LoadedNavigationBarState) {
                    return BottomNavigationBar(
                      items: state.items,
                      onTap: (index) {
                        if (_navigationBarBloc.refreshMode) {
                          _recommendBloc.add(FetchRecommendEvent());
                          return;
                        }
                        _tabBloc.add(SwitchTabEvent(switchIndex: index));
                      },
                      backgroundColor: Colors.white,
                      currentIndex: state.curIndex,
                      elevation: 8,
                      selectedItemColor: AppColors.primaryTextColor,
                      unselectedItemColor: AppColors.normalTextColor,
                      selectedLabelStyle:
                          TextStyle(color: AppColors.primaryTextColor),
                      unselectedLabelStyle:
                          TextStyle(color: AppColors.normalTextColor),
                      type: BottomNavigationBarType.fixed,
                      iconSize: 20,
                    );
                  }
                  return SizedBox();
                }),
            body: BlocBuilder(
              bloc: _tabBloc,
              builder: (_, TabState state) {
                int curIndex = 0;
                if (state is SwitchTabState) {
                  curIndex = state.switchIndex;
                }

                return Stack(
                  children: <Widget>[
                    Opacity(
                      opacity: (curIndex == 0 ? 1 : 0),
                      child: _pages[0],
                    ),
                    Opacity(
                      opacity: (curIndex == 1 ? 1 : 0),
                      child: _pages[1],
                    ),
                    Opacity(
                      opacity: (curIndex == 3 ? 1 : 0),
                      child: _pages[2],
                    ),
                    Opacity(
                      opacity: (curIndex == 4 ? 1 : 0),
                      child: _pages[3],
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
