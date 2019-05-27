import 'package:today/ui/ui_base.dart';
import 'package:today/ui/page/main/main.dart';
import 'package:today/data/state/login.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NormalPage(
      title: NormalTitle("登录"),
      body: Container(
        child: Center(
          child: RaisedButton(
            onPressed: () async {
              UserInfo userInfo = await ApiRequest.register();
              debugPrint("注册成功：${userInfo.username}");
              SimpleStorage.putString(key_username, userInfo.username);
              await LoginState.init();
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return MainPage();
              }));
            },
            child: Text("注册"),
          ),
        ),
      ),
    );
  }
}
