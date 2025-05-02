import 'package:flutter/material.dart';

import 'package:login_signup/features/presentation/screens/profile/settings/pin_code_screen.dart';

import 'package:login_signup/features/presentation/widgets/settings/theme_selection_bottom.dart';
import 'package:login_signup/features/presentation/widgets/settings/language_selection_bottom.dart';
import 'package:login_signup/features/presentation/widgets/settings/setting_title.dart';
import 'package:login_signup/features/presentation/widgets/settings/section_header.dart';

class SettingsScreen extends StatefulWidget {
  final Function(String)? onThemeChanged;

  const SettingsScreen({super.key, this.onThemeChanged});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Theme Settings
          SectionHeader(title: 'Appearance'),
          ThemeSettingsWidget(),
          const Divider(height: 1),

          // Language Settings
          LanguageSettingsWidget(),
          const Divider(height: 1),

          // Security Section
          SectionHeader(title: 'Security'),
          SettingTile(
            icon: Icons.key,
            title: 'PIN Code',
            subtitle: 'No changes',
            onTap: () => _navigateToPinSetup(context),
          ),
          const Divider(height: 1),

          // Support Section
          SectionHeader(title: 'Support'),
          SettingTile(
            icon: Icons.help,
            title: 'Help Center',
            onTap: () => _openHelpCenter(context),
          ),
          SettingTile(
            icon: Icons.email,
            title: 'Contact Us',
            onTap: () => _contactSupport(context),
          ),
          SettingTile(
            icon: Icons.info,
            title: 'About App',
            onTap: () => _showAboutDialog(context),
          ),
        ],
      ),
    );
  }

  void _navigateToPinSetup(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PinCodeVerificationScreen(),
      ),
    );
  }

  void _openHelpCenter(BuildContext context) {
    // Implement help center navigation
  }

  void _contactSupport(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Contact Support'),
            content: const Text('Email us at: support@example.com'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'App Name',
      applicationVersion: '2.0.0',
      applicationLegalese: '© 2025 Next Octet',
    );
  }
}
