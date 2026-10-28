import 'package:flutter/material.dart';

abstract class StyleConstants {
  static const EdgeInsets edgeInsets16 = EdgeInsets.all(16);
  static const EdgeInsets edgeInsetsH16V16 = EdgeInsets.symmetric(horizontal: 16, vertical: 16);
  static const EdgeInsets edgeInsetsH24V32 = EdgeInsets.symmetric(horizontal: 24, vertical: 32);

  static const BorderRadius radius8 = BorderRadius.all(Radius.circular(8));

  static const List<BoxShadow> cardShadow = [BoxShadow(color: Color(0x14000000), blurRadius: 16, offset: Offset(0, 4))];
}
