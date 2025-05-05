import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login_signup/config/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/presentation/screens/auth/forgot_password_screen.dart';
import 'features/presentation/screens/auth/signin_screen.dart';
import 'features/presentation/screens/auth/signup_screen.dart';
import 'features/presentation/screens/profile/profile_screen.dart';
import 'features/presentation/screens/profile/settings/settings_screen.dart';
import 'features/presentation/screens/todo/todo_screen.dart';
import 'features/presentation/screens/welcome_screen.dart';
import 'features/presentation/screens/home/home_screen.dart';

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

  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const WelcomeScreen()),
      GoRoute(
        path: '/signin',
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
      GoRoute(path: '/todo', builder: (context, state) => const TodoPage()),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfilePage(),
        routes: <RouteBase>[
          GoRoute(
            path: 'settings',
            builder: (context, state) {
              return SettingsScreen();
            },
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }

  // Widget build(BuildContext context) {
  // counter test: search_screen.dart
  // return BlocProvider(
  //   create: (context) => CounterBloc(),
  //   child: MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     theme: lightMode,
  //     darkTheme: darkMode,
  //     themeMode: _themeMode,
  //     home: WelcomeScreen(),
  //     routes: {
  //       '/settings':
  //           (context) => SettingsScreen(),
  //     },
  //   ),
  // );
}
