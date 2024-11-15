import 'package:flutter/material.dart';
import 'color_manager.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: ColorManager.lightBackgroundColor,
      fontFamily: 'Satoshi',
      iconTheme: IconThemeData(color: Colors.grey.shade800),
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.grey.shade800),
        elevation: 0,
        titleTextStyle: const TextStyle(
          color: ColorManager.blackTextColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
      ),
      cardColor: ColorManager.lightCardColor,
      dividerColor: Colors.grey.shade400,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        backgroundColor: ColorManager.lightCardColor,
        selectedItemColor: ColorManager.blackTextColor,
        selectedLabelStyle: const TextStyle(
          color: ColorManager.blackTextColor,
          fontWeight: FontWeight.bold,
        ),
        unselectedItemColor: Colors.grey.shade600,
      ),
      tabBarTheme: TabBarTheme(
        labelColor: ColorManager.blackTextColor,
        unselectedLabelColor: Colors.grey.shade600,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: Colors.transparent,
        dividerColor: Colors.transparent,
        indicator: BoxDecoration(
          color: ColorManager.lightCardColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        overlayColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          return states.contains(WidgetState.pressed)
              ? Colors.grey.shade200
              : null;
        }),
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        labelPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      textTheme: TextTheme(
        bodyLarge: const TextStyle(color: ColorManager.blackTextColor, fontSize: 14),
        bodyMedium: TextStyle(color: Colors.grey.shade800, fontSize: 14),
        bodySmall: TextStyle(color: Colors.grey.shade600, fontSize: 12),
        labelLarge: const TextStyle(color: ColorManager.whiteTextColor, fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: ColorManager.darkBackgroundColor,
      fontFamily: 'Satoshi',
      iconTheme: IconThemeData(color: Colors.grey.shade200),
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.grey.shade200),
        elevation: 0,
        titleTextStyle: const TextStyle(
          color: ColorManager.whiteTextColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
      ),
      cardColor: ColorManager.darkCardColor,
      dividerColor: Colors.grey.shade700,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        backgroundColor: ColorManager.darkCardColor,
        selectedItemColor: ColorManager.whiteTextColor,
        selectedLabelStyle: const TextStyle(
          color: ColorManager.whiteTextColor,
          fontWeight: FontWeight.bold,
        ),
        unselectedItemColor: Colors.grey.shade400,
      ),
      tabBarTheme: TabBarTheme(
        labelColor: ColorManager.whiteTextColor,
        unselectedLabelColor: Colors.grey.shade400,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: Colors.transparent,
        dividerColor: Colors.transparent,
        indicator: BoxDecoration(
          color: ColorManager.darkCardColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade800),
        ),
        overlayColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
          return states.contains(MaterialState.pressed)
              ? Colors.grey.shade800
              : null;
        }),
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        labelPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      textTheme: TextTheme(
        bodyLarge: const TextStyle(color: ColorManager.whiteTextColor, fontSize: 14),
        bodyMedium: TextStyle(color: Colors.grey.shade200, fontSize: 14),
        bodySmall: TextStyle(color: Colors.grey.shade400, fontSize: 12),
        labelLarge: const TextStyle(color: ColorManager.blackTextColor, fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }
}