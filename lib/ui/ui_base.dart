import 'package:flutter/material.dart';
export 'package:flutter/material.dart';
export 'package:today/data/network/request.dart';
export 'package:today/data/storage/simple_storage.dart';
export 'package:today/data/constants.dart';
export 'package:today/data/state/login.dart';
export 'package:toast/toast.dart';
export 'package:after_layout/after_layout.dart';
export 'package:today/ui/login.dart';
export 'package:today/widget/init.dart';
import 'package:today/util/global.dart';
export 'package:today/util/global.dart';
export 'package:today/data/event/events.dart';
export 'dart:async';
import 'package:flutter_easyrefresh/easy_refresh.dart';
export 'package:today/widget/init.dart';
export 'dart:math';

class NormalPage extends StatefulWidget {
  final Widget title;
  final Widget body;
  final bool needAppBar;

  NormalPage({this.title, @required this.body, this.needAppBar = true});

  @override
  State<StatefulWidget> createState() {
    return _NormalPageState();
  }
}

class _NormalPageState extends State<NormalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (widget.needAppBar
          ? AppBar(
              title: widget.title,
            )
          : null),
      body: widget.body,
    );
  }

  @override
  void initState() {
    super.initState();
  }
}

class NormalTitle extends StatelessWidget {
  final String title;

  NormalTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(title);
  }
}

class NormalRefresh extends StatelessWidget {
  final Widget child;

  NormalRefresh({@required this.child});

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      child: child,
      autoLoad: true,
      firstRefresh: true,
    );
  }
}

class AppColors {
  AppColors._();

  static final primaryTextColor = Color(0xFF333333);

  static final normalTextColor = Color(0xFF666666);
}

class AppDimens {
  AppDimens._();
}
