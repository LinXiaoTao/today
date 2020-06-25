import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:today/data/model/models.dart';

@immutable
abstract class CommentDetailState extends Equatable {}

class InitialCommentDetailState extends CommentDetailState {
  @override
  List<Object> get props => [];
}

class LoadedCommentDetailState extends CommentDetailState {
  final Comment comment;

  LoadedCommentDetailState(this.comment);

  @override
  String toString() {
    return 'LoadedCommentDetailState{comment: $comment}';
  }

  @override
  List<Object> get props => [comment];
}
