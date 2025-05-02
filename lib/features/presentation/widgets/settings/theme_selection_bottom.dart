import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:login_signup/features/presentation/widgets/settings/setting_title.dart';
import 'package:login_signup/features/presentation/widgets/custom_radio_list_title.dart';

class ThemeSettingsWidget extends StatefulWidget {
  const ThemeSettingsWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ThemeSettingsWidgetState createState() => _ThemeSettingsWidgetState();
}

class _ThemeSettingsWidgetState extends State<ThemeSettingsWidget> {
  String _currentTheme = 'light';

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentTheme = prefs.getString('theme') ?? 'system';
    });
  }

  Future<void> _saveTheme(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', theme);
    setState(() {
      _currentTheme = theme;
    });
  }

  String get _themeDisplayName {
    switch (_currentTheme) {
      case 'light':
        return 'Light Theme';
      case 'dark':
        return 'Dark Theme';
      default:
        return 'System Default';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SettingTile(
      icon: Icons.color_lens,
      title: 'Theme',
      subtitle: _themeDisplayName,
      onTap: () => _showThemeOptions(context),
    );
  }

  void _showThemeOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ThemeSelectionBottom(
          currentTheme: _currentTheme,
          onThemeChanged: (value) {
            Navigator.pop(context);
            _saveTheme(value);
          },
        );
      },
    );
  }
}

class ThemeSelectionBottom extends StatelessWidget {
  final String currentTheme;
  final ValueChanged<String> onThemeChanged;

  const ThemeSelectionBottom({
    super.key,
    required this.currentTheme,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomRadioListTile(
          value: 'light',
          title: 'Light Theme',
          groupValue: currentTheme,
          onChanged: onThemeChanged,
        ),
        CustomRadioListTile(
          value: 'dark',
          title: 'Dark Theme',
          groupValue: currentTheme,
          onChanged: onThemeChanged,
        ),
        CustomRadioListTile(
          value: 'system',
          title: 'System Default',
          groupValue: currentTheme,
          onChanged: onThemeChanged,
        ),
      ],
    );
  }
}
