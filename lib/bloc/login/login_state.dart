import 'package:equatable/equatable.dart';
import 'package:today/data/model/models.dart';

abstract class LoginState extends Equatable {}

class InitialLoginState extends LoginState {
  @override
  List<Object> get props => [];
}

class InputPhoneState extends LoginState {
  final String phone;

  InputPhoneState(this.phone);

  @override
  List<Object> get props => [phone];
}

class LoadedSmsCodeState extends LoginState {
  final String msg;
  final bool success;
  final String phone;

  LoadedSmsCodeState(this.success, this.msg, this.phone);

  @override
  List<Object> get props => [success, msg, phone];
}

class InputSmsState extends LoginState {
  final String smsCode;

  InputSmsState(this.smsCode);

  @override
  List<Object> get props => [smsCode];
}

class LoginResultState extends LoginState {
  final UserProfile userProfile;

  LoginResultState(this.userProfile);

  @override
  List<Object> get props => [userProfile];
}
