import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:today/data/network/request.dart';

class CommentDetailBloc extends Bloc<CommentDetailEvent, CommentDetailState> {
  @override
  CommentDetailState get initialState => InitialCommentDetailState();

  @override
  Stream<CommentDetailState> mapEventToState(
    CommentDetailEvent event,
  ) async* {
    if (event is FetchCommentDetailEvent) {
      yield LoadedCommentDetailState(
          await ApiRequest.commentDetail(event.id, event.targetType));
    }
  }
}
