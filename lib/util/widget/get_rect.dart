import 'package:flutter/widgets.dart';

extension GetRectOnRenderBox on GlobalKey {
  Rect get globalRect {
    assert(currentContext != null);
    final RenderBox renderBoxContainer = currentContext!.findRenderObject()! as RenderBox;
    return Rect.fromPoints(
        renderBoxContainer.localToGlobal(
          renderBoxContainer.paintBounds.topLeft,
        ),
        renderBoxContainer.localToGlobal(renderBoxContainer.paintBounds.bottomRight));
  }
}
