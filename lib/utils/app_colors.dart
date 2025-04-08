import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryBlue = Color(0xFF569AD7);
  static const Color secondaryBlue = Color(0xFF304A61);

  static const MaterialColor primarySwatch = MaterialColor(
    0xFF569AD7,
    <int, Color>{
      50: Color(0xFFE1F0FA),
      100: Color(0xFFB3D9F2),
      200: Color(0xFF81C1EA),
      300: Color(0xFF4FA9E2),
      400: Color(0xFF2F96DC),
      500: Color(0xFF0F83D6), // base color
      600: Color(0xFF0B76C0),
      700: Color(0xFF0968A8),
      800: Color(0xFF075A90),
      900: Color(0xFF044067),
    },
  );
}
