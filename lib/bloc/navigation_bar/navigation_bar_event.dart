import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NavigationBarEvent extends Equatable {}

/// 获取 navigation bar
class FetchNavigationBarEvent extends NavigationBarEvent {
  final bool fetchPost;

  FetchNavigationBarEvent({this.fetchPost = true}) : super();

  @override
  String toString() {
    return 'FetchNavigationBarEvent{fetchPost: $fetchPost}';
  }

  @override
  List<Object> get props => [fetchPost];
}

/// 切换 home navigation bar
class SwitchHomeNavigationBarEvent extends NavigationBarEvent {
  final bool refreshMode;

  SwitchHomeNavigationBarEvent({this.refreshMode = false}) : super();

  @override
  String toString() {
    return 'SwitchHomeNavigationBarEvent{refreshMode: $refreshMode}';
  }

  @override
  List<Object> get props => [refreshMode];
}
