import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NavigationBarEvent extends Equatable {
  NavigationBarEvent([List props = const []]) : super(props);
}

/// 获取 navigation bar
class FetchNavigationBarEvent extends NavigationBarEvent {
  final bool fetchPost;

  FetchNavigationBarEvent({this.fetchPost = true}) : super([fetchPost]);

  @override
  String toString() {
    return 'FetchNavigationBarEvent{fetchPost: $fetchPost}';
  }
}

/// 切换 home navigation bar
class SwitchHomeNavigationBarEvent extends NavigationBarEvent {
  final bool refreshMode;

  SwitchHomeNavigationBarEvent({this.refreshMode = false})
      : super([refreshMode]);

  @override
  String toString() {
    return 'SwitchHomeNavigationBarEvent{refreshMode: $refreshMode}';
  }
}
