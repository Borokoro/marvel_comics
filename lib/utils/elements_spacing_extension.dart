import 'package:flutter/material.dart';

extension ElementsSpacingExtension on List<Widget> {
  List<Widget> _wrapWithWidgetAfterEach(Widget widget) {
    List<Widget> result = [];

    for (int index = 0; index < length; index++) {
      result.add(this[index]);
      if (index != length - 1) {
        result.add(widget);
      }
    }
    return result;
  }

  List<Widget> withHorizontalElementsSpacing(double spacing) {
    return _wrapWithWidgetAfterEach(SizedBox(width: spacing));
  }

  List<Widget> withVerticalElementsSpacing(double spacing) {
    return _wrapWithWidgetAfterEach(SizedBox(height: spacing));
  }

  List<Widget> withDivider(Widget divider) {
    List<Widget> result = [];
    result = _wrapWithWidgetAfterEach(divider);
    return result;
  }
}
