import 'package:flutter/material.dart';
import 'package:today/data/constants.dart';
import 'package:today/data/state/login.dart';

class AppNetWorkImage extends StatelessWidget {
  final String src;
  final double width;
  final double height;
  final BoxFit fit;
  final AlignmentGeometry alignment;
  final BorderRadiusGeometry borderRadius;
  final BoxBorder border;

  AppNetWorkImage(
      {@required this.src,
      this.width,
      this.height,
      this.fit = BoxFit.cover,
      this.alignment = Alignment.center,
      this.borderRadius,
      this.border});

  @override
  Widget build(BuildContext context) {
    if (!LoginState.isLogin) {
      return SizedBox(
        width: 0,
        height: 0,
      );
    }
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(2),
          border: border,
          image: DecorationImage(
              fit: fit,
              alignment: alignment,
              image: NetworkImage(src, headers: {
                key_access_token: LoginState.accessToken,
                key_device_id: LoginState.deviceId
              }))),
    );
  }
}
