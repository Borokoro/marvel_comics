import 'package:flutter/material.dart';
import 'package:super_heroes/constants/color_constants.dart';
import 'package:super_heroes/utils/text_theme_extension.dart';

class TitleAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TitleAppBar({super.key, required this.title});

  final String title;

  static const double _height = 96;
  static const double _titleSpacing = 16;

  @override
  Size get preferredSize => const Size.fromHeight(_height);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return AppBar(
      toolbarHeight: _height,
      centerTitle: false,
      titleSpacing: _titleSpacing,
      backgroundColor: ColorConstants.bgCanvas,
      scrolledUnderElevation: 0,
      title: Text(title, style: textTheme.headingH1_32),
    );
  }
}
