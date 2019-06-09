import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math show max;

class WrapStack extends MultiChildRenderObjectWidget {
  WrapStack({List<Widget> children = const <Widget>[]})
      : super(children: children);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return WrapStackRender();
  }
}

class WrapStackRender extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, WrapStackParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, WrapStackParentData> {
  @override
  void performLayout() {
    if (childCount == 0) {
      size = constraints.biggest;
      assert(size.isFinite);
      return;
    }

    double width = constraints.minWidth;
    double height = constraints.minHeight;

    RenderBox child = firstChild;
    while (child != null) {
      final WrapStackParentData childParentData = child.parentData;
      if (!childParentData.wrap) {
        /// measure
        child.layout(constraints, parentUsesSize: true);
        final Size childSize = child.size;
        width = math.max(width, childSize.width);
        height = math.max(height, childSize.height);
      }

      child = childParentData.nextSibling;
    }

    /// use not wrap size
    size = Size(width, height);

    final fixConstraints = BoxConstraints.tight(Size(width, height));
    child = firstChild;
    while (child != null) {
      final WrapStackParentData childParentData = child.parentData;
      if (childParentData.wrap) {
        /// measure
        child.layout(fixConstraints, parentUsesSize: true);
        final Size childSize = child.size;
      }

      child = childParentData.nextSibling;
    }
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    return _getIntrinsicDimension(
        (RenderBox child) => child.getMinIntrinsicWidth(height));
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    return _getIntrinsicDimension(
        (RenderBox child) => child.getMaxIntrinsicWidth(height));
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    return _getIntrinsicDimension(
        (RenderBox child) => child.getMinIntrinsicHeight(width));
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return _getIntrinsicDimension(
        (RenderBox child) => child.getMaxIntrinsicHeight(width));
  }

  @override
  double computeDistanceToActualBaseline(TextBaseline baseline) {
    return defaultComputeDistanceToHighestActualBaseline(baseline);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! WrapStackParentData)
      child.parentData = WrapStackParentData();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }

  double _getIntrinsicDimension(double mainChildSizeGetter(RenderBox child)) {
    double extent = 0.0;
    RenderBox child = firstChild;
    while (child != null) {
      final WrapStackParentData childParentData = child.parentData;
      if (!childParentData.wrap)
        extent = math.max(extent, mainChildSizeGetter(child));
      assert(child.parentData == childParentData);
      child = childParentData.nextSibling;
    }
    return extent;
  }
}

class WrapStackParentData extends ContainerBoxParentData<RenderBox> {
  /// 使用 parent size
  bool wrap = false;

  @override
  String toString() {
    return 'WrapStackParentData{wrap: $wrap}';
  }
}

class WrapStackChild extends ParentDataWidget<WrapStack> {
  final bool warp;

  WrapStackChild({Widget child, this.warp = true}) : super(child: child);

  @override
  void applyParentData(RenderObject renderObject) {
    assert(renderObject.parentData is WrapStackParentData);
    final WrapStackParentData parentData = renderObject.parentData;
    bool needsLayout = false;
    if (parentData.wrap != this.warp) {
      parentData.wrap = this.warp;
      needsLayout = true;
    }

    if (needsLayout) {
      final AbstractNode targetParent = renderObject.parent;
      if (targetParent is RenderObject) targetParent.markNeedsLayout();
    }
  }
}
