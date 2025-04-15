import 'package:flutter/material.dart';

import '../utils/fonts_res.dart';

TextStyle josefinSansBold(
    {Color? color,
    double? fontSize,
    double? letterSpacing,
    List<Shadow>? shadow,
    TextDecoration? textdeco,
    double? height,
    TextOverflow? overflow,
    FontWeight? fontWeight}) {
  return TextStyle(
    color: color ?? Colors.white,
    fontWeight: fontWeight ?? FontWeight.w400,
    shadows: shadow,
    fontSize: fontSize ?? 14,
    fontFamily: fontsRes.josefinSansBold,
    letterSpacing: letterSpacing ?? 0,
    decoration: textdeco ?? TextDecoration.none,
    height: height,
    overflow: overflow,
  );
}

TextStyle notoSerifSemiBold(
    {Color? color,
    double? fontSize,
    double? letterSpacing,
    List<Shadow>? shadow,
    TextDecoration? textdeco,
    double? height,
    TextOverflow? overflow,
    FontWeight? fontWeight}) {
  return TextStyle(
    color: color,
    fontWeight: fontWeight ?? FontWeight.w400,
    shadows: shadow,
    fontSize: fontSize ?? 14,
    fontFamily: fontsRes.notoSerifSemiBold,
    letterSpacing: letterSpacing ?? 0,
    decoration: textdeco ?? TextDecoration.none,
    height: height,
    overflow: overflow,
  );
}

TextStyle errorStyle = const TextStyle(
  color: Colors.red,
  fontSize: 11,
  fontFamily: fontsRes.rubikRegular,
);
TextStyle rubikRegular(
    {Color? color,
    double? fontSize,
    double? letterSpacing,
    List<Shadow>? shadow,
    TextDecoration? textdeco,
    double? height,
    TextOverflow? overflow,
    FontWeight? fontWeight}) {
  return TextStyle(
    color: color ?? Colors.white,
    fontWeight: fontWeight ?? FontWeight.w400,
    shadows: shadow,
    fontSize: fontSize ?? 14,
    fontFamily: fontsRes.rubikRegular,
    letterSpacing: letterSpacing ?? 0,
    decoration: textdeco ?? TextDecoration.none,
    height: height,
    overflow: overflow,
  );
}

TextStyle rubikMedium(
    {Color? color,
    double? fontSize,
    double? letterSpacing,
    List<Shadow>? shadow,
    TextDecoration? textdeco,
    double? height,
    TextOverflow? overflow,
    FontWeight? fontWeight}) {
  return TextStyle(
    color: color,
    fontWeight: fontWeight,
    shadows: shadow,
    fontSize: fontSize ?? 14,
    fontFamily: fontsRes.rubikMedium,
    letterSpacing: letterSpacing ?? 0,
    decoration: textdeco ?? TextDecoration.none,
    height: height,
    overflow: overflow,
  );
}
