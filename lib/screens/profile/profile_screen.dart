import 'dart:io';
import 'package:flutter/material.dart';
import 'package:login_signup/screens/auth/signin_screen.dart';
import 'package:login_signup/screens/profile/editProfile_screen.dart';
import 'package:login_signup/screens/profile/settings_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Add a File variable to store the profile image
  File? _profileImage;

  // Sample user data - now structured with the fields we need
  Map<String, dynamic> _userData = {
    'firstName': 'Zakaria',
    'lastName': 'El idrissi',
    'email': 'zakaria@admin.com',
    'phone': '+212641498334',
    'job': 'Front-end & Flutter Developer',
    'cin': 'AB123456',
    'bio':
        'Front-end & Flutter developer passionate about creating beautiful and functional applications.',
    'placeOfWork': 'Next Octet',
    'joined': 'March 2025',
    'hoursWorked': 100,
  };

  // Helper getter to display full name
  String get _fullName => "${_userData['firstName']} ${_userData['lastName']}";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile header with cover image
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

            // Profile picture, overlapping the cover image
            Transform.translate(
              offset: const Offset(0, -50),
              child: Column(
                children: [
                  // Avatar - Updated to show either the selected image or default
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 3),
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child:
                        _profileImage == null
                            ? const CircleAvatar(
                              radius: 60,
                              backgroundImage: AssetImage(
                                'assets/images/default-avatar.svg',
                              ),
                            )
                            : CircleAvatar(
                              radius: 60,
                              backgroundImage: FileImage(_profileImage!),
                            ),
                  ),

                  // User name
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

                  // User email
                  Text(
                    _userData['email'],
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),

                  // Bio
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

                  // Stats row
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatColumn(
                          'Hours worked',
                          _userData['hoursWorked'].toString(),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Edit profile button - Updated to pass and receive both image and user data
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () async {
                        // Navigate to EditProfileScreen and pass the current image and user data
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

                        // Handle the returned data (both image and updated user data)
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

                  // Rest of your profile page...
                  _buildInfoSection(),
                  _buildActivitySection(),
                  _buildAboutSection(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Your existing helper methods...
  Widget _buildStatColumn(String title, String count) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(title, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildInfoSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Personal Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildInfoRow(
                    Icons.location_on,
                    'place of work',
                    _userData['placeOfWork'],
                  ),
                  const Divider(),
                  _buildInfoRow(
                    Icons.calendar_today,
                    'Joined',
                    _userData['joined'],
                  ),
                  const Divider(),
                  _buildInfoRow(Icons.work, 'Occupation', _userData['job']),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 10),
          Text(
            '$title:',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivitySection() {
    // Existing implementation
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Recent Activity',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Card(
            elevation: 2,
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                List<Map<String, dynamic>> activities = [
                  {
                    'title': 'Updated profile picture',
                    'time': '2 days ago',
                    'icon': Icons.photo_camera,
                  },
                  {
                    'title': 'Completed Flutter project',
                    'time': '1 week ago',
                    'icon': Icons.code,
                  },
                  {
                    'title': 'Joined the platform',
                    'time': '4 months ago',
                    'icon': Icons.person_add,
                  },
                ];

                return ListTile(
                  leading: Icon(activities[index]['icon'], color: Colors.blue),
                  title: Text(activities[index]['title']),
                  subtitle: Text(activities[index]['time']),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // Handle activity tap
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    // Existing implementation
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'About & Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Card(
            elevation: 2,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.settings, color: Colors.blue),
                  title: const Text('Settings'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
                      ),
                    );
                  },
                ),
                const Divider(height: 0),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text('Log Out'),
                  onTap: () {
                    _showLogoutDialog();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Log Out'),
            content: const Text('Are you sure you want to log out?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const SignInScreen(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
                child: const Text(
                  'Log Out',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }
}
