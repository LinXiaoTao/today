import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:today/data/model/models.dart';

@immutable
abstract class PersonalDetailState extends Equatable {}

class InitialPersonalDetailState extends PersonalDetailState {
  @override
  List<Object> get props => [];
}

class LoadedPersonalDataState extends PersonalDetailState {
  final UserProfile userInfo;

  LoadedPersonalDataState(this.userInfo) : super();

  @override
  String toString() {
    return 'LoadedPersonalDataState{userInfo: $userInfo}';
  }

  @override
  List<Object> get props => [userInfo];
}
