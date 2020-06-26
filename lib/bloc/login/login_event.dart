import 'package:equatable/equatable.dart';
import 'package:today/ui/ui_base.dart';

abstract class LoginEvent extends Equatable {}

class InputPhoneEvent extends LoginEvent {
  final String phone;

  InputPhoneEvent(this.phone);

  @override
  List<Object> get props => [phone];
}

class FetchSmsCodeEvent extends LoginEvent {
  final String phone;

  FetchSmsCodeEvent(this.phone);

  @override
  List<Object> get props => [phone];
}

class InputSmsEvent extends LoginEvent {
  final String smsCode;

  InputSmsEvent(this.smsCode);

  @override
  List<Object> get props => [smsCode];
}

class FetchLoginEvent extends LoginEvent {
  final String smsCode;
  final BuildContext context;

  FetchLoginEvent(this.smsCode, this.context);

  @override
  List<Object> get props => [smsCode, context];
}
