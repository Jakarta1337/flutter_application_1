import 'package:flutter/material.dart';

class RecentActivitySection extends StatelessWidget {
  const RecentActivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> activities = [
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
              itemCount: activities.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
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
}
