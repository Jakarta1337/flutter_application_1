import 'package:flutter/material.dart';

class StatColumn extends StatelessWidget {
  final String title;
  final String count;

  const StatColumn({super.key, required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
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
}
