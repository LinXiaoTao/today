import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:today/data/network/request.dart';

class PersonalDetailBloc
    extends Bloc<PersonalDetailEvent, PersonalDetailState> {
  @override
  PersonalDetailState get initialState => InitialPersonalDetailState();

  @override
  Stream<PersonalDetailState> mapEventToState(
    PersonalDetailEvent event,
  ) async* {
    if (event is FetchPersonalDataEvent) {
      UserProfile userProfile =
          await ApiRequest.profile(username: event.username);
      yield LoadedPersonalDataState(userProfile);
    }
  }
}
