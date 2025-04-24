import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget buildEditableField(
  String label,
  TextEditingController controller, {
  required Function(String) onChanged,
  required String? Function(String?) validator,
  List<TextInputFormatter>? inputFormatters,
  TextInputType? keyboardType,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
      validator: validator,
      onChanged: onChanged,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
    ),
  );
}
