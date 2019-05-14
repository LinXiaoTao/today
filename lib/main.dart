import 'package:flutter/material.dart';
import 'package:today/ui/home.dart';
import 'package:today/data/state/login.dart';
import 'package:today/ui/login.dart';
import 'package:today/util/global.dart';

void main() async {
  await LoginState.init();
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
          scaffoldBackgroundColor: Color(0xfff0f3f5),
          appBarTheme: AppBarTheme(color: Color(0xffffe411))),
      home: (LoginState.isLogin ? HomePage() : LoginPage()),
    );
  }
}
