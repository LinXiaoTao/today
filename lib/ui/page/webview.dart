import 'package:today/ui/ui_base.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  final String title;

  WebViewPage(this.url, this.title);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {
    return NormalPage(
        title: NormalTitle(widget.title),
        body: WebView(
          onWebViewCreated: (WebViewController webViewController) {},
          onPageFinished: (url) {},
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
        ));
  }
}
