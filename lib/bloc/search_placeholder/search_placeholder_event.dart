import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SearchPlaceholderEvent extends Equatable {
}

class FetchSearchPlaceHolderEvent extends SearchPlaceholderEvent {
  @override
  String toString() {
    return 'FetchSearchPlaceHolderEvent{}';
  }

  @override
  List<Object> get props => [];
}
