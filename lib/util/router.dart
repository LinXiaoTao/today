import 'package:flutter/material.dart';
import 'package:today/ui/page/pages.dart';

class AppRouter {
  AppRouter._() {}

  static router(String url, BuildContext context) {
    if (url == null || url.isEmpty) return;

    var uri = Uri.parse(url);

    if (uri == null) return;
    print('router uri = ${uri}');

    switch (uri.scheme) {
      case 'jike':
        {
          if (uri.host == 'page.jk') {
            // 页面
            var page = uri.pathSegments[0];
            switch (page) {
              // 用户页面
              case 'user':
                {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return PersonalDetailPage(
                      username: uri.pathSegments[1],
                    );
                  }));
                }
                break;
            }
          }
        }
        break;
      case 'http':
      case 'https':
        {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return WebViewPage(url, '');
          }));
        }
        break;
    }
  }
}
