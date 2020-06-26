import 'package:flutter/material.dart';
import 'package:today/data/state/login.dart';
import 'package:today/ui/page/login/login.dart';
import 'package:today/ui/page/main/main.dart';
import 'package:today/util/global.dart';
import 'package:today/ui/ui_base.dart';
import 'package:today/data/network/request.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LoginUserState.init();
  await ApiRequest.initDio();
  runApp(TodayApp());
}

class TodayApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Global.context = context;
    return MaterialApp(
      title: 'Today',
      theme: ThemeData(
          primarySwatch: Colors.yellow,
          accentColor: AppColors.accentColor,
          scaffoldBackgroundColor: Color(0xfff0f3f5),
          appBarTheme: AppBarTheme(color: AppColors.statusBarColor)),
      home: (LoginUserState.isLogin ? MainPage() : LoginPage()),
    );
  }
}
