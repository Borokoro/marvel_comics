import 'package:flutter/material.dart';

abstract class IconConstants {
  static const String _fontFamilyIcons = "super-heroes-icons";

  static const IconData home = IconData(0xAD00, fontFamily: _fontFamilyIcons);
  static const IconData search = IconData(0xAD01, fontFamily: _fontFamilyIcons);
  static const IconData noResults = IconData(0xAD02, fontFamily: _fontFamilyIcons);
  static const IconData startSearch = IconData(0xAD03, fontFamily: _fontFamilyIcons);
}
