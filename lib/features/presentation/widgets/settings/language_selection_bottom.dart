import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:login_signup/features/presentation/widgets/settings/setting_title.dart';
import 'package:login_signup/features/presentation/widgets/custom_radio_list_title.dart';

class LanguageSettingsWidget extends StatefulWidget {
  const LanguageSettingsWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LanguageSettingsWidgetState createState() => _LanguageSettingsWidgetState();
}

class _LanguageSettingsWidgetState extends State<LanguageSettingsWidget> {
  String _currentLanguage = 'en';

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentLanguage = prefs.getString('language') ?? 'en';
    });
  }

  Future<void> _saveLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
    setState(() {
      _currentLanguage = language;
    });
  }

  String get _languageDisplayName {
    switch (_currentLanguage) {
      case 'fr':
        return 'French';
      case 'ar':
        return 'Arabic';
      default:
        return 'English';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SettingTile(
      icon: Icons.language,
      title: 'Language',
      subtitle: _languageDisplayName,
      onTap: () => _showLanguageOptions(context),
    );
  }

  void _showLanguageOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return LanguageSelectionBottom(
          currentLanguage: _currentLanguage,
          onLanguageChanged: (value) {
            Navigator.pop(context);
            _saveLanguage(value);
          },
        );
      },
    );
  }
}

class LanguageSelectionBottom extends StatelessWidget {
  final String currentLanguage;
  final ValueChanged<String> onLanguageChanged;

  const LanguageSelectionBottom({
    super.key,
    required this.currentLanguage,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomRadioListTile(
          value: 'en',
          title: 'English',
          groupValue: currentLanguage,
          onChanged: onLanguageChanged,
        ),
        CustomRadioListTile(
          value: 'fr',
          title: 'French',
          groupValue: currentLanguage,
          onChanged: onLanguageChanged,
        ),
        CustomRadioListTile(
          value: 'ar',
          title: 'Arabic',
          groupValue: currentLanguage,
          onChanged: onLanguageChanged,
        ),
      ],
    );
  }
}
