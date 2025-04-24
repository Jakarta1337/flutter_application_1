import 'package:flutter/material.dart';
import 'package:login_signup/screens/welcome_screen.dart';
import 'package:login_signup/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login_signup/screens/profile/settings/settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Fetch saved theme preference
  final prefs = await SharedPreferences.getInstance();
  final themePref = prefs.getString('theme') ?? 'system';

  runApp(MyApp(themePref: themePref));
}

class MyApp extends StatefulWidget {
  final String themePref;

  const MyApp({super.key, required this.themePref});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    _themeMode = _getThemeMode(widget.themePref);
  }

  // Convert string theme preference to ThemeMode
  ThemeMode _getThemeMode(String pref) {
    switch (pref) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  // Update theme preference and notify root
  void _updateTheme(String newPref) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', newPref);
    setState(() {
      _themeMode = _getThemeMode(newPref);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode, // light mode from your theme.dart
      darkTheme: darkMode, // dark mode from your theme.dart
      themeMode: _themeMode, // Apply theme mode based on preference
      home: WelcomeScreen(onThemeChanged: _updateTheme),
      routes: {
        '/settings': (context) => SettingsScreen(onThemeChanged: _updateTheme),
      },
    );
  }
}
