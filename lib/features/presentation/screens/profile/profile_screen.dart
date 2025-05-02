import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_signup/features/presentation/screens/profile/edit_profile_screen.dart';

import 'package:login_signup/features/presentation/widgets/profile/recent_activity_section.dart';
import 'package:login_signup/features/presentation/widgets/profile/about_settings_section.dart';
import 'package:login_signup/features/presentation/widgets/profile/profile_info_section.dart';
import 'package:login_signup/features/presentation/widgets/profile/stat_column.dart';

import 'package:login_signup/features/presentation/widgets/dialogs/logout_dialog.dart';
import 'package:login_signup/features/data/user_data.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage;
  Map<String, dynamic> _userData = Map.from(userData);
  String get _fullName => "${_userData['firstName']} ${_userData['lastName']}";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue, Colors.lightBlueAccent],
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -50),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 3),
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child:
                        _profileImage == null
                            ? CircleAvatar(
                              radius: 60,
                              child: ClipOval(
                                child: SvgPicture.asset(
                                  'assets/images/default-avatar.svg',
                                  width: 130,
                                  height: 130,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                            : CircleAvatar(
                              radius: 60,
                              backgroundImage: FileImage(_profileImage!),
                            ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      _fullName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Text(
                    _userData['email'],
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    child: Text(
                      _userData['bio'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        StatColumn(
                          title: 'Hours worked',
                          count: _userData['hoursWorked'].toString(),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => EditProfileScreen(
                                  initialImage: _profileImage,
                                  userData: _userData,
                                ),
                          ),
                        );
                        if (result != null && result is Map<String, dynamic>) {
                          setState(() {
                            if (result['image'] != null) {
                              _profileImage = result['image'] as File;
                            }
                            if (result['userData'] != null) {
                              _userData =
                                  result['userData'] as Map<String, dynamic>;
                            }
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text('Edit Profile'),
                    ),
                  ),

                  const SizedBox(height: 20),
                  ProfileInfoSection(userData: _userData),
                  const RecentActivitySection(),
                  AboutSettingsSection(onLogout: _showLogoutDialog),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(context: context, builder: (_) => const LogoutDialog());
  }
}
