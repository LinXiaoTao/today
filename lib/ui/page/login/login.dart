import 'package:flutter/services.dart';
import 'package:today/ui/ui_base.dart';
import 'package:today/ui/page/main/main.dart';
import 'package:today/data/state/login.dart';

class LoginPage extends StatelessWidget {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _smsCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return NormalPage(
      title: NormalTitle("登录"),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimensions.primaryPadding),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: AppDimensions.primaryPadding * 2,
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(hintText: '输入手机号码'),
              keyboardType: TextInputType.phone,
              inputFormatters: [
                LengthLimitingTextInputFormatter(11),
                WhitelistingTextInputFormatter(RegExp(r'\d'))
              ],
            ),
            Stack(
              children: <Widget>[
                TextField(
                  controller: _smsCodeController,
                  decoration: InputDecoration(hintText: '输入验证码'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(6),
                    WhitelistingTextInputFormatter(RegExp(r'\d'))
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: RaisedButton(
                    color: AppColors.yellow,
                    textColor: AppColors.primaryTextColor,
                    child: Container(child: Text('获取验证码')),
                    onPressed: () {
                      _getSmsCode();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: AppDimensions.primaryPadding * 2,
            ),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return SizedBox(
                  width: constraints.maxWidth,
                  child: RaisedButton(
                    color: AppColors.yellow,
                    textColor: AppColors.primaryTextColor,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: AppDimensions.primaryPadding),
                      child: Text('验证'),
                    ),
                    onPressed: () {
                      _login(context);
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  void _getSmsCode() async {
    if (_phoneController.text.isEmpty) {
      showToast('输入手机号码');
      return;
    }
    try {
      await ApiRequest.getSmsCode(_phoneController.text);
      showToast('获取验证码成功');
    } catch (err) {
      showToast(err.toString());
    }
  }

  void _login(BuildContext context) async {
    if (_phoneController.text.isEmpty) {
      showToast('输入手机号码');
      return;
    }
    if (_smsCodeController.text.isEmpty) {
      showToast('输入验证码');
      return;
    }
    try {
      UserProfile userProfile = await ApiRequest.mixLoginWithPhone(
          _phoneController.text, _smsCodeController.text);
      debugPrint("登录成功：${userProfile.user.username}");
      SimpleStorage.putString(key_username, userProfile.user.username);
      await LoginState.init();
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return MainPage();
      }));
    } catch (err) {
      showToast(err.toString());
    }
  }

  void _register(BuildContext context) async {
    UserInfo userInfo = await ApiRequest.register();
    debugPrint("注册成功：${userInfo.username}");
    SimpleStorage.putString(key_username, userInfo.username);
    await LoginState.init();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return MainPage();
    }));
  }
}
