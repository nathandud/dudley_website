import 'package:flutter/material.dart';

class DDColors {
  //Branding Colors
  static const Color backgroundGreen = Color(0xFF0A5C5A);
  static const Color yellowCream = Color(0xFFF4FEC1);
  static const Color vermillionRed = Color(0xFFF64740);

  static MaterialColor greenSwatch = MaterialColor(
    backgroundGreen.value,
    <int, Color>{
      50: backgroundGreen.withOpacity(0.1),
      100: backgroundGreen.withOpacity(0.2),
      200: backgroundGreen.withOpacity(0.3),
      300: backgroundGreen.withOpacity(0.4),
      400: backgroundGreen.withOpacity(0.5),
      500: backgroundGreen.withOpacity(0.6),
      600: backgroundGreen.withOpacity(0.7),
      700: backgroundGreen.withOpacity(0.8),
      800: backgroundGreen.withOpacity(0.9),
      900: backgroundGreen.withOpacity(1.0),
    },
  );

  //Socials
  static const Color githubPurple = Color(0xFF6f42c1);
  static const Color linkedInBlue = Color(0xFF0077B5);
  static const Color twitterBlue = Color(0xFF1DA1F2);
  static const Color stackOverflowOrange = Color(0xFFF48024);
}
