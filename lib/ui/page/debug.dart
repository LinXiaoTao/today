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
            _DebugPositioned(
              Text("1"),
              tag: "1",
            ),
            _DebugPositioned(
              Text("2"),
              tag: "2",
              left: 10,
            ),
            _DebugPositioned(
              Text("3"),
              tag: "3",
              left: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class _DebugPositioned extends Positioned {
  @override
  ParentDataElement<Stack> createElement() {
    debugPrint("createElement");
    return _DebugParentDataElement(this);
  }

  final String tag;

  _DebugPositioned(Widget child, {this.tag, double left})
      : super(child: child, left: left);
}

class _DebugParentDataElement extends ParentDataElement<Stack> {
  _DebugParentDataElement(ParentDataWidget<RenderObjectWidget> widget)
      : super(widget);

  @override
  RenderObject get renderObject {
    debugPrint("renderObject = ${super.renderObject}");
    return super.renderObject;
  }
}
