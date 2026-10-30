import 'package:flutter/material.dart';
import 'package:super_heroes/constants/color_constants.dart';
import 'package:super_heroes/view/pages/search/components/search_field.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppBar({super.key});

  static const double _height = 88;
  static const double _titleSpacing = 16;
  static const double _scrolledUnderElevation = 4;

  @override
  Size get preferredSize => const Size.fromHeight(_height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: _height,
      titleSpacing: _titleSpacing,
      automaticallyImplyLeading: false,
      backgroundColor: ColorConstants.bgCanvas,
      surfaceTintColor: ColorConstants.transparent,
      shadowColor: ColorConstants.shadow,
      scrolledUnderElevation: _scrolledUnderElevation,
      title: const SearchField(),
    );
  }
}
