import 'package:flutter/material.dart';
import 'package:super_heroes/constants/color_constants.dart';

ThemeData appTheme(BuildContext context) {
  final ThemeData themeData = ThemeData.light(useMaterial3: true);
  return themeData.copyWith(
    textTheme: themeData.textTheme.apply(bodyColor: ColorConstants.textPrimary),
    scaffoldBackgroundColor: ColorConstants.bgCanvas,
  );
}
