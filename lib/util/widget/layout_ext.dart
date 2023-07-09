import 'package:flutter/cupertino.dart';

extension ColumnExt on Column {
  // 仿照 ListView.separated 实现的 Column.separated
  static Column separated({required List<Widget> children, required Widget separator}) {
    final widgets = <Widget>[];
    for (int i = 0; i < children.length; i++) {
      widgets.add(children[i]);
      if (i != children.length - 1) {
        widgets.add(separator);
      }
    }
    return Column(children: widgets);
  }
}

extension RowExt on Row {
  static Row separated({required List<Widget> children, required Widget separator}) {
    final widgets = <Widget>[];
    for (int i = 0; i < children.length; i++) {
      widgets.add(children[i]);
      if (i != children.length - 1) {
        widgets.add(separator);
      }
    }
    return Row(children: widgets);
  }
}
