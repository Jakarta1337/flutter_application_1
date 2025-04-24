import 'package:flutter/material.dart';

class CustomRadioListTile extends StatelessWidget {
  final String value;
  final String title;
  final String groupValue;
  final ValueChanged<String> onChanged;

  const CustomRadioListTile({
    super.key,
    required this.value,
    required this.title,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<String>(
      value: value,
      groupValue: groupValue,
      title: Text(title),
      onChanged: (String? newValue) {
        if (newValue != null) {
          onChanged(newValue);
        }
      },
    );
  }
}
