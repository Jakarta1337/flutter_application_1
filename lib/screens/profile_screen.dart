import 'package:flutter/material.dart';
import 'package:login_signup/screens/signin_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Sample user data
  final Map<String, dynamic> _userData = {
    'name': 'John Doe',
    'email': 'john.doe@example.com',
    'bio':
        'Flutter developer passionate about creating beautiful and functional applications.',
    'location': 'New York, USA',
    'joined': 'January 2023',
    'following': 235,
    'followers': 186,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Profile')),
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
                  // Avatar
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 3),
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: const CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                        'https://i.pravatar.cc/300',
                      ),
                    ),
                  ),

                  // User name
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      _userData['name'],
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
                          'Following',
                          _userData['following'].toString(),
                        ),
                        Container(
                          height: 30,
                          width: 1,
                          color: Colors.grey[300],
                        ),
                        _buildStatColumn(
                          'Followers',
                          _userData['followers'].toString(),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Edit profile button
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to edit profile screen
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Edit Profile tapped'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text('Edit Profile'),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Info cards section
                  _buildInfoSection(),

                  // Activity section
                  _buildActivitySection(),

                  // About & Settings section
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

  // Helper method to build stat columns
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

  // Info section with cards
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
                    'Location',
                    _userData['location'],
                  ),
                  const Divider(),
                  _buildInfoRow(
                    Icons.calendar_today,
                    'Joined',
                    _userData['joined'],
                  ),
                  const Divider(),
                  _buildInfoRow(Icons.work, 'Occupation', 'Flutter Developer'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method for info row items
  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 10),
          Text(
            '$title:',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 10),
          Text(value, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
        ],
      ),
    );
  }

  // Recent activity section
  Widget _buildActivitySection() {
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

  // About & Settings section
  Widget _buildAboutSection() {
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
                  leading: const Icon(Icons.info, color: Colors.blue),
                  title: const Text('About App'),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            title: const Text('About App'),
                            content: const Text(
                              'This is a Flutter demo app showcasing profile features, navigation, and UI components.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                    );
                  },
                ),

                const Divider(height: 0),
                ListTile(
                  leading: const Icon(Icons.policy, color: Colors.blue),
                  title: const Text('Privacy Policy'),
                  onTap: () {
                    // You can navigate or show dialog here
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Privacy Policy tapped')),
                    );
                  },
                ),

                const Divider(height: 0),
                ListTile(
                  leading: const Icon(Icons.rule, color: Colors.blue),
                  title: const Text('Terms of Service'),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Terms tapped')),
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

                  // TODO: Add FirebaseAuth.instance.signOut(); if using Firebase

                  // Navigate to LoginScreen and remove all previous routes
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const SignInScreen(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
                child: const Text('Log Out'),
              ),
            ],
          ),
    );
  }
}
