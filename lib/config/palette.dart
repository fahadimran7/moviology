import 'package:flutter/material.dart';

class Palette {
  static MaterialColor kToDark = const MaterialColor(
    0xFF00BE82, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xFFE8EAF6), //10%
      100: Color(0xFFC5CAE9), //20%
      200: Color(0xFF9FA8DA), //30%
      300: Color(0xFF7986CB), //40%
      400: Color(0xFF5C6BC0), //50%
      500: Color(0xFF3F51B5), //60%
      600: Color(0xFF3949AB), //70%
      700: Color(0xFF303F9F), //80%
      800: Color(0xFF283593), //90%
      900: Color(0xFF1A237E), //100%
    },
  );
}
