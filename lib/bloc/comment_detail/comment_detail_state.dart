import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:today/data/model/models.dart';

@immutable
abstract class CommentDetailState extends Equatable {
  CommentDetailState([List props = const []]) : super(props);
}

class InitialCommentDetailState extends CommentDetailState {}

class LoadedCommentDetailState extends CommentDetailState {
  final Comment comment;

  LoadedCommentDetailState(this.comment) : super([comment]);

  @override
  String toString() {
    return 'LoadedCommentDetailState{comment: $comment}';
  }
}
