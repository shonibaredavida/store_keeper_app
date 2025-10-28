import 'package:flutter/widgets.dart';

class AppTextStyles {
  static const String poppins = 'Poppins';
  static const String merriweather = 'Merriweather';

  static TextStyle dynamic(
    double size, {
    Color? color,
    FontWeight? weight,
    double? height,
    double? spacing,
    FontStyle? style,
  }) {
    return TextStyle(
      fontSize: size,
      color: color,
      fontWeight: weight,
      height: height == null ? null : height / size,
      letterSpacing: spacing,
      fontStyle: style,
    );
  }

  static const header = TextStyle(
    height: 1.5,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    fontFamily: merriweather,
  );

  // caption
  static const captionLg = TextStyle(
    height: 1.3,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    fontFamily: poppins,
  );

  static const captionMd = TextStyle(
    height: 1.3,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: poppins,
  );

  static const captionSm = TextStyle(
    height: 1.3,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: poppins,
  );

  // body
  static const bodyLg = TextStyle(
    height: 1.3,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    fontFamily: poppins,
  );

  static const bodyMd = TextStyle(
    height: 1.3,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: poppins,
  );

  static const bodySm = TextStyle(
    height: 1.5,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: poppins,
  );

  // label
  static const labelLg = TextStyle(
    height: 1.3,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    fontFamily: poppins,
  );

  static const labelMd = TextStyle(
    height: 1.3,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontFamily: poppins,
  );

  static const labelSm = TextStyle(
    height: 1.3,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    fontFamily: poppins,
  );
}
