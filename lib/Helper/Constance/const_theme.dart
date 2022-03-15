import 'package:commerce/Helper/Constance/const_colors.dart';
import 'const_functions.dart';
import 'package:flutter/material.dart';


final ThemeData themeLight = ThemeData(
  brightness: Brightness.light ,
  primaryColor: lightMainColor,
  unselectedWidgetColor: lightColorThree,
  scaffoldBackgroundColor: normalWhite,
  backgroundColor: lightMainColor,
  cardColor: normalGrey.shade300,
  fontFamily: 'Poppins',
  indicatorColor: normalBlack,
  colorScheme: const ColorScheme.light().copyWith(
    primary: Colors.red ,
    secondary: Colors.red ,
  ) ,
  switchTheme: SwitchThemeData(
    trackColor: materialStateColor(darkColorThree),
    thumbColor: materialStateColor(lightMainColor),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.all(lightMainColor),
    checkColor: MaterialStateProperty.all(normalWhite),
    // overlayColor: MaterialStateProperty.all(Colors.white)
  ),
  appBarTheme: const AppBarTheme(
      backgroundColor: normalWhite,
      foregroundColor: normalBlack,
      actionsIconTheme: IconThemeData(
          color: normalWhite,
          size: 25.0
      ),
      iconTheme: IconThemeData(
          color: normalWhite,
          size: 20.0
      )
  ),
  iconTheme: const IconThemeData(
      color: primary,
      size: 25.0
  ),
  textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: materialStateColor(lightMainColor),
        foregroundColor: materialStateColor(normalWhite),
        textStyle: materialStateStyle(const TextStyle(fontSize: 15.0,color: normalWhite,fontFamily: 'Poppins')),
        // overlayColor: materialStateColor(Colors.white),
        // shadowColor: materialStateColor(Colors.teal),
      )
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
          backgroundColor: materialStateColor(lightMainColor),
          foregroundColor: materialStateColor(normalWhite),
          textStyle: materialStateStyle(const TextStyle(fontSize: 15.0,color: normalWhite,fontFamily: 'Poppins')),
          // overlayColor: materialStateColor(Colors.white),
          // shadowColor: materialStateColor(Colors.teal),
          side: MaterialStateProperty.all(const BorderSide(color: Colors.grey))
      )
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: materialStateColor(lightMainColor),
        foregroundColor: materialStateColor(normalWhite),
        textStyle: materialStateStyle(const TextStyle(fontSize: 15.0,color: normalWhite,fontFamily: 'Poppins')),
        // overlayColor: materialStateColor(Colors.white),
        // shadowColor: materialStateColor(Colors.teal),
        // side: MaterialStateProperty.all(const BorderSide(color: lightColorThree))
      )
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: lightMainColor,
    foregroundColor: normalWhite,
    // splashColor: Colors.white,
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: darkColorThree,
    circularTrackColor: lightMainColor,
    linearTrackColor: lightMainColor,
  ),
  dividerTheme: const DividerThemeData(
      color: lightColorThree,
      thickness: 1.5),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Colors.blue,
    modalBackgroundColor: Colors.orange,
  ) ,
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: normalWhite,
    iconColor: normalBlack,
    suffixIconColor: lightColorThree,
    prefixIconColor: lightColorThree,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: normalBlack),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: lightColorThree),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: lightColorThree),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: lightColorThree),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: lightColorThree),
    ),

  ) ,
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: darkColorTow ,
    actionTextColor: lightMainColor ,
  ) ,
  bannerTheme: const MaterialBannerThemeData(
      backgroundColor: lightMainColor,
      contentTextStyle: TextStyle( color: normalWhite , fontSize: 17.0 )
  ) ,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: normalWhite,
      elevation: 9.0,
      selectedItemColor: lightMainColor ,
      unselectedItemColor: lightColorThree
  ),
);



final ThemeData themeDark = ThemeData(
  brightness: Brightness.dark ,
  primaryColor: darkMainColor ,
  scaffoldBackgroundColor: darkColorTow ,
  backgroundColor: darkColorOne ,
  indicatorColor: darkColorTow ,
  cardColor: darkColorTow,
  colorScheme: const ColorScheme.dark() ,
  appBarTheme: const AppBarTheme(
      backgroundColor: darkColorOne ,
      foregroundColor: normalWhite ,
      actionsIconTheme: IconThemeData(
          color: normalWhite ,
          size: 25.0
      ),
      iconTheme: IconThemeData(
          color: normalWhite ,
          size: 25.0
      )
  ) ,
  iconTheme: const IconThemeData(
      color: normalWhite,
      size: 20.0
  ) ,
  dividerTheme: const DividerThemeData(
      color: darkColorThree,
      thickness: 1.5) ,
  switchTheme: SwitchThemeData(
    trackColor: materialStateColor(darkColorTow),
    //overlayColor: materialStateColor(Colors.teal),
    thumbColor: materialStateColor(darkMainColor),
  ) ,
  checkboxTheme: CheckboxThemeData(
    fillColor: materialStateColor(darkMainColor),
    checkColor: materialStateColor(normalWhite),
    //  overlayColor: MaterialStateProperty.all(Colors.white)
  ) ,
  textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: materialStateColor(darkMainColor),
        foregroundColor: materialStateColor(normalWhite),
        textStyle: materialStateStyle(const TextStyle(fontSize: 15.0,color: normalWhite,fontFamily: 'Poppins')),
      )
  ) ,
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
          backgroundColor: materialStateColor(darkMainColor),
          foregroundColor: materialStateColor(normalWhite),
          textStyle: materialStateStyle(const TextStyle(fontSize: 15.0,color: normalWhite,fontFamily: 'Poppins')),
          // overlayColor: materialStateColor(Colors.white),
          // shadowColor: materialStateColor(Colors.teal),
          side: MaterialStateProperty.all(const BorderSide(color: normalWhite))
      )
  ) ,
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: materialStateStyle(const TextStyle(fontSize: 15.0,color: normalWhite,fontFamily: 'Poppins')),
        backgroundColor: materialStateColor(darkMainColor),
        foregroundColor: materialStateColor(normalWhite),
        // overlayColor: materialStateColor(Colors.white),
        // shadowColor: materialStateColor(Colors.teal),
      )
  ) ,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: darkMainColor,
    foregroundColor: normalWhite,
    // splashColor: Colors.red,
  ) ,
  listTileTheme: const ListTileThemeData(
    tileColor: darkColorOne,
    textColor: normalWhite,
    iconColor: normalWhite,
  ) ,
  progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: darkColorThree,
      circularTrackColor: darkMainColor,
      linearTrackColor: darkMainColor,
      refreshBackgroundColor: darkColorThree
  ) ,
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: darkColorOne,
    iconColor: normalWhite,
    suffixIconColor: normalWhite,
    prefixIconColor: normalWhite,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: normalWhite),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: normalWhite),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: normalWhite),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: normalWhite),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: normalWhite),
    ),

  ) ,
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: normalWhite ,
    actionTextColor: darkMainColor ,
  ) ,
  bannerTheme: const MaterialBannerThemeData(
      backgroundColor: darkColorOne,
      contentTextStyle: TextStyle(color: normalWhite , fontSize: 17.0)
  ) ,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: darkColorOne,
      selectedItemColor: darkMainColor ,
      unselectedItemColor: normalWhite
  ),
);