import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NavigationBarState extends Equatable {
  NavigationBarState();
}

class InitialMainState extends NavigationBarState {
  @override
  List<Object> get props => [];
}

/// 加载
class LoadedNavigationBarState extends NavigationBarState {
  final List<BottomNavigationBarItem> items;
  final int curIndex;

  LoadedNavigationBarState(this.items, {this.curIndex = 0})
      : super();

  @override
  String toString() {
    return 'LoadedNavigationBarState{items: $items, curIndex: $curIndex}';
  }

  @override
  List<Object> get props => [items, curIndex];
}
