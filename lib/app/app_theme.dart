// ignore_for_file: deprecated_member_use

import 'package:ewabooks/app/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



enum AppTheme { dark, light }

final appThemeData = {
  AppTheme.light: ThemeData(
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(color: primaryColor_),
        foregroundColor: textColor
      ),
    ),
    checkboxTheme: const CheckboxThemeData(
      fillColor: MaterialStatePropertyAll(teritoryColor_),
    ),
    // scaffoldBackgroundColor: pageBackgroundColor,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: teritoryColor_,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
    ),
    bottomAppBarColor: teritoryColor_,
    //textTheme
    fontFamily: "Manrope",
    errorColor: errorMessageColor,
    // highlightColor: const Color(0xffffc600),
    dropdownMenuTheme: const DropdownMenuThemeData(
      textStyle: TextStyle(color: primaryColor_),
      menuStyle: MenuStyle(
        backgroundColor: MaterialStatePropertyAll(teritoryColor_),

      ),
    ),
    textSelectionTheme:
        const TextSelectionThemeData(selectionHandleColor: teritoryColor_),
    switchTheme: SwitchThemeData(
      thumbColor: const MaterialStatePropertyAll(teritoryColor_),
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return teritoryColor_.withOpacity(0.3);
        }
        return primaryColorDark;
      }),
    ),
  ),
  AppTheme.dark: ThemeData(
    brightness: Brightness.dark,
    fontFamily: "Manrope",
    errorColor: errorMessageColor.withOpacity(0.7),
    switchTheme: SwitchThemeData(
        thumbColor: const MaterialStatePropertyAll(teritoryColor_),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return teritoryColor_.withOpacity(0.3);
          }
          return primaryColor_.withOpacity(0.2);
        })),
  )
};
