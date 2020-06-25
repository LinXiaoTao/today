import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:today/data/model/models.dart';

@immutable
abstract class SearchPlaceholderState extends Equatable {}

class InitialSearchPlaceholderState extends SearchPlaceholderState {
  @override
  List<Object> get props => [];
}

class LoadedSearchPlaceHolderState extends SearchPlaceholderState {
  final SearchPlaceholder searchPlaceholder;

  LoadedSearchPlaceHolderState(this.searchPlaceholder) : super();

  @override
  String toString() {
    return 'LoadedSearchPlaceHolderState{searchPlaceholder: $searchPlaceholder}';
  }

  @override
  List<Object> get props => [searchPlaceholder];
}
