import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:today/widget/image.dart';
import './bloc.dart';
import 'package:today/data/model/models.dart';
import 'package:today/data/network/request.dart';
import 'package:flutter/material.dart';
import 'package:today/bloc/blocs.dart';

class NavigationBarBloc extends Bloc<NavigationBarEvent, NavigationBarState> {
  final BottomNavigationBarItem _homeItem = BottomNavigationBarItem(
    backgroundColor: Colors.white,
    icon: ImageIcon(AssetImage('images/ic_tabbar_home_unselected.png')),
    title: Text('首页'),
    activeIcon: ImageIcon(AssetImage('images/ic_tabbar_home_selected.png')),
  );

  final BottomNavigationBarItem _refreshItem = BottomNavigationBarItem(
      backgroundColor: Colors.white,
      icon: Image.asset('images/ic_tabbar_refresh.png'),
      title: Text('刷新'));

  final BottomNavigationBarItem _activityItem = BottomNavigationBarItem(
      backgroundColor: Colors.white,
      icon: ImageIcon(AssetImage('images/ic_tabbar_activity_unselected.png')),
      title: Text('动态'),
      activeIcon:
          ImageIcon(AssetImage('images/ic_tabbar_activity_selected.png')));

  final BottomNavigationBarItem _emptyItem = BottomNavigationBarItem(
    backgroundColor: Colors.white,
    title: SizedBox(),
    icon: SizedBox(),
  );

  final BottomNavigationBarItem _chatItem = BottomNavigationBarItem(
      title: Text('聊天'),
      backgroundColor: Colors.white,
      icon: ImageIcon(AssetImage('images/ic_tabbar_chat_unselected.png')),
      activeIcon: ImageIcon(AssetImage('images/ic_tabbar_chat_selected.png')));

  final BottomNavigationBarItem _mineItem = BottomNavigationBarItem(
      title: Text('我的'),
      backgroundColor: Colors.white,
      icon: ImageIcon(AssetImage('images/ic_tabbar_personal_unselected.png')),
      activeIcon:
          ImageIcon(AssetImage('images/ic_tabbar_personal_selected.png')));

  BottomNavigationBarItem _postItem;

  bool _refreshMode = false;

  final TabBloc tabBloc;

  StreamSubscription _tabSubscription;

  bool get refreshMode {
    return _refreshMode;
  }

  NavigationBarBloc(this.tabBloc) {
    _tabSubscription = tabBloc.listen((state) {
      if (state is SwitchTabState) {
        if (this.state is LoadedNavigationBarState) {
          this.add(FetchNavigationBarEvent(fetchPost: false));
        }
      }
    });
  }

  @override
  NavigationBarState get initialState => InitialMainState();

  @override
  Stream<NavigationBarState> mapEventToState(
    NavigationBarEvent event,
  ) async* {
    if (event is FetchNavigationBarEvent) {
      yield* _mapFetchNavigationBarEvent(event);
    } else if (event is SwitchHomeNavigationBarEvent) {
      _refreshMode = event.refreshMode;
      yield LoadedNavigationBarState([
        (_refreshMode ? _refreshItem : _homeItem),
        _activityItem,
        _postItem ?? _emptyItem,
        _chatItem,
        _mineItem
      ], curIndex: tabBloc.curTabIndex);
    }
  }

  Stream<LoadedNavigationBarState> _mapFetchNavigationBarEvent(
      FetchNavigationBarEvent event) async* {
    if (!event.fetchPost) {
      yield LoadedNavigationBarState([
        (_refreshMode ? _refreshItem : _homeItem),
        _activityItem,
        _postItem,
        _chatItem,
        _mineItem
      ], curIndex: tabBloc.curTabIndex);
    } else {
      yield LoadedNavigationBarState([
        (_refreshMode ? _refreshItem : _homeItem),
        _activityItem,
        _emptyItem,
        _chatItem,
        _mineItem
      ], curIndex: tabBloc.curTabIndex);

      /// 加载 post icon
      CentralEntry centralEntry = await ApiRequest.centralEntry();
      yield LoadedNavigationBarState([
        (_refreshMode ? _refreshItem : _homeItem),
        _activityItem,
        _postItem = BottomNavigationBarItem(
            backgroundColor: Colors.white,
            title: SizedBox(),
            icon: AppNetWorkImage(
              src: centralEntry.picUrl,
              width: 50,
              height: 50 * 0.68,
            )),
        _chatItem,
        _mineItem
      ], curIndex: tabBloc.curTabIndex);
    }
  }

  @override
  Future<void> close() {
    _tabSubscription.cancel();
    return super.close();
  }
}
