import 'package:today/ui/ui_base.dart';
import 'package:today/ui/page/main/home.dart';
import 'package:today/ui/page/main/activity.dart';
import 'package:today/ui/page/main/chat.dart';
import 'package:today/ui/page/main/mine.dart';
import 'package:today/data/repository/main_model.dart';

class MainPage extends StatefulWidget {
  @override
  State createState() {
    return _MainState();
  }
}

class _MainState extends State<MainPage> with AfterLayoutMixin<MainPage> {
  bool _canRefresh = false;

  List<Widget> _pages;

  int _curIndex = 0;

  final MainModel _model = MainModel();

  StreamSubscription _subscription;

  final BottomNavigationBarItem _home = BottomNavigationBarItem(
    backgroundColor: Colors.white,
    icon: ImageIcon(AssetImage('images/ic_tabbar_home_unselected.png')),
    title: Text('首页'),
    activeIcon: ImageIcon(AssetImage('images/ic_tabbar_home_selected.png')),
  );

  final BottomNavigationBarItem _refreshHome = BottomNavigationBarItem(
      backgroundColor: Colors.white,
      icon: Image.asset('images/ic_tabbar_refresh.png'),
      title: Text('刷新'));

  final BottomNavigationBarItem _activity = BottomNavigationBarItem(
      backgroundColor: Colors.white,
      icon: ImageIcon(AssetImage('images/ic_tabbar_activity_unselected.png')),
      title: Text('动态'),
      activeIcon:
          ImageIcon(AssetImage('images/ic_tabbar_activity_selected.png')));

  final BottomNavigationBarItem _empty = BottomNavigationBarItem(
    backgroundColor: Colors.white,
    title: SizedBox(),
    icon: SizedBox(),
  );

  final BottomNavigationBarItem _chat = BottomNavigationBarItem(
      title: Text('聊天'),
      backgroundColor: Colors.white,
      icon: ImageIcon(AssetImage('images/ic_tabbar_personal_unselected.png')));

  final BottomNavigationBarItem _mine = BottomNavigationBarItem(
      title: Text('我的'),
      backgroundColor: Colors.white,
      icon: ImageIcon(AssetImage('images/ic_tabbar_personal_unselected.png')));

  @override
  void initState() {
    _pages = [
      HomePage((refresh) {
        if (_canRefresh != refresh) {
          setState(() {
            _canRefresh = refresh;
          });
        }
      }),
      ActivityPage(),
      ChatPage(),
      MinePage()
    ];
    _subscription = Global.eventBus.on<RefreshTokenEvent>().listen((event) {
      afterFirstLayout(context);
    });
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _model.requestCentralEntry();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: _model,
      child: ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
          List<BottomNavigationBarItem> bottomItems = [];
          if (_canRefresh) {
            bottomItems.add(_refreshHome);
          } else {
            bottomItems.add(_home);
          }
          bottomItems.add(_activity);
          if (model.centralEntry != null) {
            bottomItems.add(BottomNavigationBarItem(
                backgroundColor: Colors.white,
                title: SizedBox(),
                icon: AppNetWorkImage(
                  src: model.centralEntry.picUrl,
                  width: 50,
                  height: 50 * 0.68,
                )));
          } else {
            bottomItems.add(_empty);
          }
          bottomItems.add(_chat);
          bottomItems.add(_mine);

          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              items: bottomItems,
              onTap: (index) {
                debugPrint('index = $_curIndex');

                if (index == 0 && _curIndex == index && _canRefresh) {
                  Global.eventBus.fire(RefreshHomeEvent());
                }

                if (_curIndex != index) {
                  setState(() {
                    _curIndex = index;
                  });
                }
              },
              backgroundColor: Colors.white,
              currentIndex: _curIndex,
              elevation: 8,
              selectedItemColor: AppColors.primaryTextColor,
              unselectedItemColor: AppColors.normalTextColor,
              selectedLabelStyle: TextStyle(color: AppColors.primaryTextColor),
              unselectedLabelStyle: TextStyle(color: AppColors.normalTextColor),
              type: BottomNavigationBarType.fixed,
              iconSize: 20,
            ),
            body: Stack(
              children: <Widget>[
                Opacity(
                  opacity: (_curIndex == 0 ? 1 : 0),
                  child: _pages[0],
                ),
                Opacity(
                  opacity: (_curIndex == 1 ? 1 : 0),
                  child: _pages[1],
                ),
                Opacity(
                  opacity: (_curIndex == 3 ? 1 : 0),
                  child: _pages[2],
                ),
                Opacity(
                  opacity: (_curIndex == 4 ? 1 : 0),
                  child: _pages[3],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
