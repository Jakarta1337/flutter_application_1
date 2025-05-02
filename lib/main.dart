import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_signup/feautures/presentation/screens/repo.dart';
import 'package:login_signup/config/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:login_signup/feautures/presentation/screens/bloc/auth_bloc.dart';
import 'package:login_signup/feautures/presentation/screens/search/bloc/counter_bloc.dart';
import 'package:login_signup/feautures/presentation/screens/welcome_screen.dart';
import 'package:login_signup/feautures/presentation/screens/profile/settings/settings_screen.dart';

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
  // ignore: library_private_types_in_public_api
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
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     theme: lightMode,
  //     darkTheme: darkMode,
  //     themeMode: _themeMode,
  //     home: WelcomeScreen(onThemeChanged: _updateTheme),
  //     routes: {
  //       '/settings': (context) => SettingsScreen(onThemeChanged: _updateTheme),
  //     },
  //   );
  // }
  Widget build(BuildContext context) {
    // counter test: search_screen.dart
    // return BlocProvider(
    //   create: (context) => CounterBloc(),
    //   child: MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     theme: lightMode,
    //     darkTheme: darkMode,
    //     themeMode: _themeMode,
    //     home: WelcomeScreen(onThemeChanged: _updateTheme),
    //     routes: {
    //       '/settings':
    //           (context) => SettingsScreen(onThemeChanged: _updateTheme),
    //     },
    //   ),
    // );

    // login test: test_screen.dart
    return MultiRepositoryProvider(
      providers: [RepositoryProvider(create: (_) => AuthRepository())],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CounterBloc>(
            create: (BuildContext context) => CounterBloc(),
          ),
          BlocProvider<AuthBloc>(
            create:
                (context) =>
                    AuthBloc(RepositoryProvider.of<AuthRepository>(context)),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightMode,
          darkTheme: darkMode,
          themeMode: _themeMode,
          home: WelcomeScreen(onThemeChanged: _updateTheme),
          routes: {
            '/settings':
                (context) => SettingsScreen(onThemeChanged: _updateTheme),
          },
        ),
      ),
    );
  }
}
