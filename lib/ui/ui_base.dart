import 'package:flutter/material.dart';
export 'package:flutter/material.dart';
export 'package:today/data/network/request.dart';
export 'package:today/data/storage/simple_storage.dart';
export 'package:today/data/constants.dart';
export 'package:today/data/state/login.dart';
export 'package:after_layout/after_layout.dart';
export 'package:today/ui/page/login/login.dart';
export 'package:today/widget/init.dart';
export 'package:today/util/global.dart';
export 'package:today/data/event/events.dart';
export 'dart:async';
export 'package:today/widget/init.dart';
export 'dart:math';
export 'package:flutter/gestures.dart';
export 'package:scoped_model/scoped_model.dart';
export 'package:fluttertoast/fluttertoast.dart';
export 'package:flutter_spinkit/flutter_spinkit.dart';

class NormalPage extends StatefulWidget {
  final Widget title;
  final Widget body;
  final bool needAppBar;
  final Color backgroundColor;

  NormalPage(
      {this.title,
      @required this.body,
      this.needAppBar = true,
      this.backgroundColor});

  @override
  State<StatefulWidget> createState() {
    return _NormalPageState();
  }
}

class _NormalPageState extends State<NormalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
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

class AppColors {
  AppColors._();

  static final primaryTextColor = Color(0xFF333333);

  static final normalTextColor = Color(0xFF666666);

  static final tipsTextColor = Color(0xFF999999);

  static final statusBarColor = yellow;

  static final accentColor = yellow;

  static final yellow = Color(0xFFFFE411);

  static final red = Color(0xFFE4583E);

  static final placeholderGray = Color(0xFFF0F3F5);

  static final blue = Color(0xFF03A9F4);

  static final green = Color(0xFF1BAF13);

  static final backgroundGray = Color(0xFFF0F3F5);

  static final backgroundFollow = Color(0xFFFBFBFB);

  static final topicBackground = Color(0xFFFAFAFA);

  static final dividerGrey = Color(0xFFDBDBDB);

  static final darkGrey = Color(0xFFF0F3F5);
}

class AppDimensions {
  AppDimensions._();

  static final primaryPadding = 12.0;

  static final smallPadding = 6.0;
}
