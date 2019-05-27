import 'package:flutter/material.dart';
import 'package:today/data/constants.dart';
import 'package:today/data/state/login.dart';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';

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
              image: CachedNetworkImageProvider(src, headers: {
                key_access_token: LoginState.accessToken,
                key_device_id: LoginState.deviceId
              }))),
    );
  }
}

class ImageUtil {
  ImageUtil._();

  /// 参考即可计算规则：com.ruguoapp.jike.view.widget.grid.GridPicLayout.e()
  /// com.ruguoapp.jike.view.widget.grid.a
  /// com.ruguoapp.jike.view.widget.grid.a.b 和 com.ruguoapp.jike.view.widget.grid.a.c

  static measureImageSize(
      {Map<String, dynamic> srcSizes, Map<String, dynamic> maxSizes}) {
    double srcW = srcSizes['w'];
    double srcH = srcSizes['h'];
    double maxW = maxSizes['w'];
    double maxH = maxSizes['h'];
    double outW = srcH;
    double outH = maxH;
    debugPrint('maxW = $maxW ; maxH = $maxH ; maxScale = ${maxW / maxH}');
    if (srcW > 0 && srcH > 0) {
      /// w / h, 1.0 / 0.5625
      double scale = max(0.5625, min(srcW / srcH, double.maxFinite));
      if (scale < (maxW / maxH)) {
        outW = (maxH * scale);
      } else {
        outH = (maxW / scale);
        outW = maxW;
      }
    } else {
      outW = outH;
    }

    debugPrint(
        'srcW = $srcW; srcH = $srcH; scale = ${srcW / srcH} ; outW = $outW; outH = $outH ; outScale = ${outW / outH}');

    return {'w': outW, 'h': outH};
  }
}
