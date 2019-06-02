import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:today/data/model/models.dart';

@immutable
abstract class SearchPlaceholderState extends Equatable {
  SearchPlaceholderState([List props = const []]) : super(props);
}

class InitialSearchPlaceholderState extends SearchPlaceholderState {}

class LoadedSearchPlaceHolderState extends SearchPlaceholderState {
  final SearchPlaceholder searchPlaceholder;

  LoadedSearchPlaceHolderState(this.searchPlaceholder)
      : super([searchPlaceholder]);

  @override
  String toString() {
    return 'LoadedSearchPlaceHolderState{searchPlaceholder: $searchPlaceholder}';
  }
}
