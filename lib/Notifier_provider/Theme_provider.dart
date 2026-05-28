import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setTheme(bool isDark) {
    _isDarkMode = isDark;
    notifyListeners();
  }

  // ✅ INIT METHOD
  Future<void> init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    notifyListeners();
  }

  // Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: const Color(0xFF2563EB),
      scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Color(0xFF111318),
        elevation: 0,
        scrolledUnderElevation: 1,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF2563EB),
        unselectedItemColor: Color(0xFF616F89),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: Color(0xFF111318)),
        displayMedium: TextStyle(color: Color(0xFF111318)),
        displaySmall: TextStyle(color: Color(0xFF111318)),
        headlineMedium: TextStyle(color: Color(0xFF111318)),
        headlineSmall: TextStyle(color: Color(0xFF111318)),
        titleLarge: TextStyle(color: Color(0xFF111318)),
        titleMedium: TextStyle(color: Color(0xFF111318)),
        titleSmall: TextStyle(color: Color(0xFF111318)),
        bodyLarge: TextStyle(color: Color(0xFF4B5563)),
        bodyMedium: TextStyle(color: Color(0xFF4B5563)),
        bodySmall: TextStyle(color: Color(0xFF616F89)),
      ),
      cardColor: Colors.white,
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return const Color(0xFF2563EB);
          }
          return Colors.grey[400];
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return const Color(0xFF2563EB).withOpacity(0.3);
          }
          return Colors.grey[300];
        }),
      ),
    );
  }

  // Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF60A5FA),
      scaffoldBackgroundColor: const Color(0xFF0F172A),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1E293B),
        foregroundColor: Color(0xFFE2E8F0),
        elevation: 0,
        scrolledUnderElevation: 1,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF1E293B),
        selectedItemColor: Color(0xFF60A5FA),
        unselectedItemColor: Color(0xFF94A3B8),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: Color(0xFFE2E8F0)),
        displayMedium: TextStyle(color: Color(0xFFE2E8F0)),
        displaySmall: TextStyle(color: Color(0xFFE2E8F0)),
        headlineMedium: TextStyle(color: Color(0xFFE2E8F0)),
        headlineSmall: TextStyle(color: Color(0xFFE2E8F0)),
        titleLarge: TextStyle(color: Color(0xFFE2E8F0)),
        titleMedium: TextStyle(color: Color(0xFFE2E8F0)),
        titleSmall: TextStyle(color: Color(0xFFE2E8F0)),
        bodyLarge: TextStyle(color: Color(0xFFCBD5E1)),
        bodyMedium: TextStyle(color: Color(0xFFCBD5E1)),
        bodySmall: TextStyle(color: Color(0xFF94A3B8)),
      ),
      cardColor: const Color(0xFF1E293B),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return const Color(0xFF60A5FA);
          }
          return Colors.grey[600];
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return const Color(0xFF60A5FA).withOpacity(0.3);
          }
          return Colors.grey[700];
        }),
      ),
    );
  }
}
