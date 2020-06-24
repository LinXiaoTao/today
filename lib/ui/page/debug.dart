import 'package:today/ui/ui_base.dart';

class DebugPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NormalPage(
      title: NormalTitle("测试页面"),
      body: Container(
        color: Colors.red,
        alignment: Alignment.center,
        child: Stack(
          children: <Widget>[
            Container(color: Colors.blue, child: Text("Hello World!")),
          ],
        ),
      ),
    );
  }
}

