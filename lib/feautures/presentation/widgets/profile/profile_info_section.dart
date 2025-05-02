import 'package:flutter/material.dart';
import 'package:login_signup/feautures/presentation/widgets/profile/info_row.dart';

class ProfileInfoSection extends StatelessWidget {
  final Map<String, dynamic> userData;

  const ProfileInfoSection({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
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
                  InfoRow(
                    icon: Icons.location_on,
                    title: 'place of work',
                    value: userData['placeOfWork'],
                  ),
                  const Divider(),
                  InfoRow(
                    icon: Icons.calendar_today,
                    title: 'Joined',
                    value: userData['joined'],
                  ),
                  const Divider(),
                  InfoRow(
                    icon: Icons.work,
                    title: 'Occupation',
                    value: userData['job'],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
