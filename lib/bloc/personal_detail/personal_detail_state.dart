import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:today/data/model/models.dart';

@immutable
abstract class PersonalDetailState extends Equatable {
  PersonalDetailState([List props = const []]) : super(props);
}

class InitialPersonalDetailState extends PersonalDetailState {}

class LoadedPersonalDataState extends PersonalDetailState {
  final UserProfile userInfo;

  LoadedPersonalDataState(this.userInfo) : super([userInfo]);

  @override
  String toString() {
    return 'LoadedPersonalDataState{userInfo: $userInfo}';
  }
}
