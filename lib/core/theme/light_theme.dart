import 'package:flutter/material.dart';
import 'package:todo_app/core/theme/app_fonts.dart';
import 'package:todo_app/core/utils/app_size.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: .light,
  switchTheme: SwitchThemeData(
    trackColor: .resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const Color(0xFF15B86C);
      }
      return const Color(0xFFCDCDCD);
    }),
    thumbColor: .resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const Color(0xFFFFFFFF);
      }
      return Colors.grey;
    }),
    trackOutlineColor: .resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return const Color(0xFF15B86C).withValues(alpha: 0.15);
      }
      return Colors.white;
    }),
    trackOutlineWidth: .resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppSize.w(18);
      }
      return AppSize.w(2);
    }),
    thumbIcon: .resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Icon(Icons.dark_mode_outlined, color: Colors.grey.shade600);
      }
      return Icon(Icons.light_mode_outlined);
    }),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF15B86C),
      foregroundColor: Colors.white,
      textStyle: TextStyle(
        fontSize: AppSize.sp(14),
        fontWeight: .bold,
        fontFamily: AppFonts.cairoFontFamily,
      ),
    ),
  ),
  fontFamily: AppFonts.cairoFontFamily,
  splashColor: Colors.transparent,
  splashFactory: NoSplash.splashFactory,

  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: AppSize.sp(28),
      color: Color(0xFF161F1B),
      fontWeight: .w400,
      fontFamily: AppFonts.cairoFontFamily,
    ),
    displayMedium: TextStyle(
      fontSize: AppSize.sp(24),
      color: Color(0xFF161F1B),
      fontWeight: .w400,
      fontFamily: AppFonts.cairoFontFamily,
    ),
    displaySmall: TextStyle(
      fontSize: AppSize.sp(16),
      color: Color(0xFF161F1B),
      fontWeight: .w400,
      fontFamily: AppFonts.cairoFontFamily,
    ),
    bodyLarge:  TextStyle(
      fontSize: AppSize.sp(16),
      color: Color(0xFF161F1B),
      fontWeight: .w400,
      fontFamily: AppFonts.cairoFontFamily,
    ),
    bodyMedium:  TextStyle(
      fontSize: AppSize.sp(14),
      color: Color(0xFF3A4640),
      fontWeight: .w400,
      fontFamily: AppFonts.cairoFontFamily,
    ),
  ),
  inputDecorationTheme: InputDecorationThemeData(
    filled: true,
    fillColor: Color(0xFFFFFFFF),
    border: _buildFieldBorder(),
    enabledBorder: _buildFieldBorder(color: Color(0xFFD1DAD6)),
    focusedBorder: _buildFieldBorder(),
    errorBorder: _buildFieldBorder(),
    focusedErrorBorder: _buildFieldBorder(),
    contentPadding: .all(AppSize.sp(16)),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Color(0xFF15B86C),
    selectionHandleColor: Color(0xFF15B86C),
    selectionColor: Color(0xFF15B86C).withValues(alpha: 0.15),
  ),
  colorScheme: ColorScheme.light(
    primaryContainer: Color(0xFFFFFFFF),
secondaryContainer: Color(0xFFFFFFFF)
  )
);
OutlineInputBorder _buildFieldBorder({Color? color, double? width}) {
  return OutlineInputBorder(
    borderRadius: .circular(16),
    borderSide: BorderSide(
      color: color ?? Color(0xFF15B86C),
      width: width ?? 1.0,
    ),
  );
}
