import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login_signup/screens/profile/pinCode_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _currentTheme = 'system';
  String _currentLanguage = 'en';

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentTheme = prefs.getString('theme') ?? 'system';
      _currentLanguage = prefs.getString('language') ?? 'en';
    });
  }

  Future<void> _saveTheme(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', theme);
    setState(() {
      _currentTheme = theme;
    });
  }

  Future<void> _saveLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
    setState(() {
      _currentLanguage = language;
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
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Theme Settings
          _buildSectionHeader('Appearance'),
          _buildSettingTile(
            icon: Icons.color_lens,
            title: 'Theme',
            subtitle: _themeDisplayName,
            onTap: () => _showThemeOptions(context),
          ),

          const Divider(height: 1),

          // Language Settings
          _buildSettingTile(
            icon: Icons.language,
            title: 'Language',
            subtitle: _languageDisplayName,
            onTap: () => _showLanguageOptions(context),
          ),

          const Divider(height: 1),

          // Security Section
          _buildSectionHeader('Security'),
          _buildSettingTile(
            icon: Icons.key,
            title: 'PIN Code',
            subtitle: 'No changes',
            onTap: () => _navigateToPinSetup(context),
          ),

          const Divider(height: 1),

          // Support Section
          _buildSectionHeader('Support'),
          _buildSettingTile(
            icon: Icons.help,
            title: 'Help Center',
            onTap: () => _openHelpCenter(context),
          ),
          _buildSettingTile(
            icon: Icons.email,
            title: 'Contact Us',
            onTap: () => _contactSupport(context),
          ),
          _buildSettingTile(
            icon: Icons.info,
            title: 'About App',
            onTap: () => _showAboutDialog(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  void _showThemeOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile(
              value: 'light',
              groupValue: _currentTheme,
              title: const Text('Light Theme'),
              onChanged: (value) {
                Navigator.pop(context);
                if (value != null) {
                  _saveTheme(value);
                }
              },
            ),
            RadioListTile(
              value: 'dark',
              groupValue: _currentTheme,
              title: const Text('Dark Theme'),
              onChanged: (value) {
                Navigator.pop(context);
                if (value != null) {
                  _saveTheme(value);
                }
              },
            ),
            RadioListTile(
              value: 'system',
              groupValue: _currentTheme,
              title: const Text('System Default'),
              onChanged: (value) {
                Navigator.pop(context);
                if (value != null) {
                  _saveTheme(value);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showLanguageOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile(
              value: 'en',
              groupValue: _currentLanguage,
              title: const Text('English'),
              onChanged: (value) {
                Navigator.pop(context);
                if (value != null) {
                  _saveLanguage(value);
                }
              },
            ),
            RadioListTile(
              value: 'fr',
              groupValue: _currentLanguage,
              title: const Text('French'),
              onChanged: (value) {
                Navigator.pop(context);
                if (value != null) {
                  _saveLanguage(value);
                }
              },
            ),
            RadioListTile(
              value: 'ar',
              groupValue: _currentLanguage,
              title: const Text('Arabic'),
              onChanged: (value) {
                Navigator.pop(context);
                if (value != null) {
                  _saveLanguage(value);
                }
              },
            ),
          ],
        );
      },
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
