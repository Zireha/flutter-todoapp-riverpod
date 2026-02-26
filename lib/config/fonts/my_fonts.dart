import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyFonts {
  static final TextStyle _primary = GoogleFonts.montserrat();
  static final TextStyle _secondary = GoogleFonts.urbanist();

  static TextStyle primaryDisplayLarge = _primary.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );

  static TextStyle primaryDisplayMedium = _primary.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static TextStyle primaryDisplaySmall = _primary.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static TextStyle primaryTitleLarge = _primary.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static TextStyle primaryTitleMedium = _primary.copyWith(
    fontSize: 10,
    fontWeight: FontWeight.w500,
  );

  static TextStyle secondaryDisplayLarge = _secondary.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w500,
  );

  static TextStyle secondaryDisplayMedium = _secondary.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );

  static TextStyle secondaryDisplaySmall = _secondary.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static TextStyle secondaryTitleLarge = _secondary.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static TextStyle secondaryTitleMedium = _secondary.copyWith(
    fontSize: 11,
    fontWeight: FontWeight.w800,
  );
}
