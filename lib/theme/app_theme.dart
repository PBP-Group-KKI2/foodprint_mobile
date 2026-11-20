import 'package:material_ui/material_ui.dart';

// Same palette as the FoodPrint website (static/css/styles.css).
class AppColors {
  static const green900 = Color(0xFF1F2A14);
  static const green800 = Color(0xFF2E3B1F);
  static const green700 = Color(0xFF4A5A2A);
  static const green600 = Color(0xFF5E6F32);
  static const green500 = Color(0xFF77894A);
  static const green100 = Color(0xFFE9EDDD);
  static const amber = Color(0xFFE0A33A);
  static const ink = Color(0xFF1E2219);
  static const inkSoft = Color(0xFF5C6355);
  static const line = Color(0xFFDCE0D3);
  static const surface = Color(0xFFF4F5F0);
  static const severityLow = Color(0xFF7E9A4B);
  static const severityMedium = Color(0xFFD9A441);
  static const severityHigh = Color(0xFFB5462F);
}

final ThemeData appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.green600,
    primary: AppColors.green600,
    secondary: AppColors.amber,
  ),
  scaffoldBackgroundColor: AppColors.surface,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.green800,
    foregroundColor: Colors.white,
  ),
  cardTheme: const CardThemeData(
    color: Colors.white,
    elevation: 0,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: AppColors.line),
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  ),
);
