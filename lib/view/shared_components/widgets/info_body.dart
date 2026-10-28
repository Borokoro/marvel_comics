import 'package:flutter/material.dart';
import 'package:super_heroes/constants/style_constants.dart';
import 'package:super_heroes/utils/elements_spacing_extension.dart';
import 'package:super_heroes/utils/text_theme_extension.dart';

class InfoBody extends StatelessWidget {
  const InfoBody({super.key, required this.title, this.action});

  final String title;
  final Widget? action;

  static const double _spacing = 12;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(padding: StyleConstants.edgeInsetsH24V32, child: _getContent(context)),
    );
  }

  Widget _getContent(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Widget? actionWidget = action;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: textTheme.bodyBase16, textAlign: TextAlign.center),
        if (actionWidget != null) ...{actionWidget},
      ].withVerticalElementsSpacing(_spacing),
    );
  }
}
