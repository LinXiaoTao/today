import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SearchPlaceholderEvent extends Equatable {
  SearchPlaceholderEvent([List props = const []]) : super(props);
}

class FetchSearchPlaceHolderEvent extends SearchPlaceholderEvent {
  @override
  String toString() {
    return 'FetchSearchPlaceHolderEvent{}';
  }
}
