import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
export 'package:flutter/material.dart';
export 'package:today/data/network/request.dart';
export 'package:today/data/storage/simple_storage.dart';
export 'package:today/data/constants.dart';
export 'package:today/data/state/login.dart';
export 'package:after_layout/after_layout.dart';
export 'package:today/ui/page/login/login.dart';
export 'package:today/util/global.dart';
export 'package:today/data/event/events.dart';
export 'dart:async';
export 'package:today/widget/widgets.dart';
export 'dart:math';
export 'package:flutter/gestures.dart';
export 'package:fluttertoast/fluttertoast.dart';
export 'package:flutter_spinkit/flutter_spinkit.dart';
export 'package:flutter_easyrefresh/phoenix_header.dart';
export 'package:today/bloc/blocs.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:today/ui/page/pages.dart';

class NormalPage extends StatefulWidget {
  final Widget title;
  final Widget body;
  final bool needAppBar;
  final Color backgroundColor;
  final Color statusBarBackgroundColor;
  final IconThemeData iconTheme;

  NormalPage(
      {this.title,
      @required this.body,
      this.needAppBar = true,
      this.backgroundColor,
      this.statusBarBackgroundColor,
      this.iconTheme});

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
              backgroundColor: widget.statusBarBackgroundColor,
              iconTheme: widget.iconTheme,
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

class PageLoadingWidget extends StatelessWidget {
  const PageLoadingWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        height: 20,
        child: SpinKitThreeBounce(
          size: 20,
          color: Colors.grey,
          duration: Duration(milliseconds: 1000),
        ),
      ),
    );
  }
}

class AppColors {
  AppColors._();

  static const primaryTextColor = Color(0xFF333333);

  static const normalTextColor = Color(0xFF666666);

  static const tipsTextColor = Color(0xFF999999);

  static const statusBarColor = Colors.white;

  static const accentColor = yellow;

  static const yellow = Color(0xFFFFE411);

  static const red = Color(0xFFE4583E);

  static const placeholderGray = Color(0xFFF0F3F5);

  static const blue = Color(0xFF03A9F4);

  static const green = Color(0xFF1BAF13);

  static const backgroundGray = Color(0xFFF0F3F5);

  static const backgroundFollow = Color(0xFFFBFBFB);

  static const topicBackground = Color(0xFFFAFAFA);

  static const dividerGrey = Color(0xFFDBDBDB);

  static const darkGrey = Color(0xFFF0F3F5);

  static final commentBackgroundGray = Colors.grey[100];
}

class AppDimensions {
  AppDimensions._();

  static final primaryPadding = 12.0;

  static final smallPadding = 6.0;
}
