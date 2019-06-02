import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NavigationBarState extends Equatable {
  NavigationBarState([List props = const []]) : super(props);
}

class InitialMainState extends NavigationBarState {}

/// 加载
class LoadedNavigationBarState extends NavigationBarState {
  final List<BottomNavigationBarItem> items;
  final int curIndex;

  LoadedNavigationBarState(this.items, {this.curIndex = 0})
      : super([items, curIndex]);

  @override
  String toString() {
    return 'LoadedNavigationBarState{items: $items, curIndex: $curIndex}';
  }
}
