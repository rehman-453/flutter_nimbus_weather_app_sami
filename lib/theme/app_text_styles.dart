import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get splashTitle => GoogleFonts.sora(
    fontSize: 44.sp,
    fontWeight: FontWeight.w800,
    letterSpacing: -1.5,
    color: Colors.white,
  );

  static TextStyle get splashSubtitle =>
      GoogleFonts.dmSans(fontSize: 16.sp, color: AppColors.splashSubtitle);

  static TextStyle get splashCaption =>
      GoogleFonts.dmMono(fontSize: 13.sp, color: AppColors.splashCaption);

  static TextStyle get heading => GoogleFonts.sora(
    fontSize: 28.sp,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.5,
    color: AppColors.navy,
  );

  static TextStyle get subheading => GoogleFonts.dmSans(
    fontSize: 15.sp,
    height: 22 / 15,
    color: AppColors.textSecondary,
  );

  static TextStyle get label => GoogleFonts.dmSans(
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
  );

  static TextStyle get input =>
      GoogleFonts.dmSans(fontSize: 16.sp, color: AppColors.navy);

  static TextStyle get inputHint =>
      GoogleFonts.dmSans(fontSize: 16.sp, color: AppColors.hint);

  static TextStyle get errorText => GoogleFonts.dmSans(
    fontSize: 13.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.error,
  );

  static TextStyle get button => GoogleFonts.dmSans(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static TextStyle get demoHint =>
      GoogleFonts.dmMono(fontSize: 12.sp, color: AppColors.hintText);

  static TextStyle get footer =>
      GoogleFonts.dmSans(fontSize: 15.sp, color: AppColors.textSecondary);

  static TextStyle get footerLink => GoogleFonts.dmSans(
    fontSize: 15.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
  );
}
