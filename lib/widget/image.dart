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

  AppNetWorkImage(
      {@required this.src,
      this.width,
      this.height,
      this.fit = BoxFit.cover,
      this.alignment = Alignment.center,
      this.borderRadius});

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
      decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(2),
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
