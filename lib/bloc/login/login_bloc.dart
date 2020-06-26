import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:today/bloc/login/login_event.dart';
import 'package:today/bloc/login/login_state.dart';
import 'package:today/data/network/request.dart';
import 'package:today/ui/ui_base.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  String _phone = '';

  @override
  LoginState get initialState => InitialLoginState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is InputPhoneEvent) {
      // 输入手机号码
      yield InputPhoneState(event.phone);
    } else if (event is FetchSmsCodeEvent) {
      // 获取验证码
      try {
        await ApiRequest.getSmsCode(event.phone);
        showToast('获取验证码成功');
        _phone = event.phone;
        yield LoadedSmsCodeState(true, '获取验证码成功', event.phone);
      } catch (err) {
        showToast(err.toString());
        yield LoadedSmsCodeState(false, err.toString(), event.phone);
      }
    } else if (event is InputSmsEvent) {
      // 输入验证码
      yield InputSmsState(event.smsCode);
    } else if (event is FetchLoginEvent) {
      try {
        UserProfile userProfile =
            await ApiRequest.mixLoginWithPhone(_phone, event.smsCode);
        debugPrint("登录成功：${userProfile.user.username}");
        SimpleStorage.putString(key_username, userProfile.user.username);
        await LoginUserState.init();
        Navigator.of(event.context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return MainPage();
        }));

        yield LoginResultState(userProfile);
      } catch (err) {
        showToast(err.toString());
      }
    }
  }
}
