import 'package:flutter/material.dart';

extension TextThemeExtension on TextTheme {
  TextStyle get headingH1_32 => const TextStyle(fontSize: 32, fontWeight: FontWeight.w700);
  TextStyle get headingH3_24 => const TextStyle(fontSize: 24, fontWeight: FontWeight.w500);
  TextStyle get bodyBase16 => const TextStyle(fontSize: 16, fontWeight: FontWeight.w400);
}
