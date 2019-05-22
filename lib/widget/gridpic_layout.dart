import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class GridPicLayout extends MultiChildRenderObjectWidget {
  GridPicLayout({List<Widget> children = const <Widget>[]})
      : super(children: children);

  @override
  GridPicLayoutRender createRenderObject(BuildContext context) {
    return GridPicLayoutRender();
  }
}

class GridPicLayoutRender extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, GridPicLayoutParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, GridPicLayoutParentData> {
  @override
  void setupParentData(RenderObject child) {
    if (child.parentData is! GridPicLayoutParentData) {
      child.parentData = GridPicLayoutParentData();
    }
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return width;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    return width;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    return 0;
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    return double.infinity;
  }

  @override
  double computeDistanceToActualBaseline(TextBaseline baseline) {
    return defaultComputeDistanceToHighestActualBaseline(baseline);
  }

  @override
  bool hitTest(HitTestResult result, {Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }

  @override
  void performLayout() {
    if (childCount == 0) {
      size = constraints.biggest;
      assert(size.isFinite);
      return;
    }

    
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }
}

class GridPicLayoutParentData extends ContainerBoxParentData<RenderBox> {}
