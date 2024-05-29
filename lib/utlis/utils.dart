import 'package:flutter/material.dart';

class AppColors {

  static const Color whitecolor = Color(0xffF5F5F5);
  static const Color blackcolor = Color(0xff000000);
  static const Color themecolor = Color(0xfff0ea36);
  static const Color scaffloadcolor = Color(0xff141424);
  static const Color txtcolor = Color(0xffa8aaad);
}
class AppStyles {
  AppStyles._();

  static TextStyle black13 = const TextStyle(
    color: AppColors.blackcolor,
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
    fontFamily: 'Poppins',
  );
  static TextStyle txt13 = const TextStyle(
    color: AppColors.txtcolor,
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
    fontFamily: 'Poppins',
  );
}