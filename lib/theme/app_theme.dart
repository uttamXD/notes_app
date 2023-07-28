import 'package:flutter/material.dart';
import '../common/constant/app_dimens.dart';

const disabledColor = Color(0xFFbcbcbc);
final primaryColor = Colors.yellow.shade300;
const secondaryColor = Color(0xFF333333);
final errorColor = Colors.red.shade300;


const darkGrey = Color(0xFF5b5b5b);

const bodyColor = Color(0xFF000000);




abstract class AppThemes {
  static ThemeData light = ThemeData.light().copyWith(
    primaryColor: primaryColor,
    textTheme: ThemeData.light()
        .textTheme
        .apply(
          bodyColor: bodyColor,
        )
        .copyWith(
          bodyMedium: ThemeData.light().textTheme.bodyMedium?.copyWith(
              color: Colors.white,
              fontSize: AppDimens.globaleFontSize,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.9),
        ),
    scaffoldBackgroundColor: Colors.black,
  );
}
