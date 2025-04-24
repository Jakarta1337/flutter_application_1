import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PinCodeField extends StatelessWidget {
  final TextEditingController controller;
  final bool isObscure;
  final String? errorText;
  final ValueChanged<String> onChanged;
  final VoidCallback onVisibilityToggle;

  const PinCodeField({
    super.key,
    required this.controller,
    required this.isObscure,
    this.errorText,
    required this.onChanged,
    required this.onVisibilityToggle,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(6),
      ],
      decoration: InputDecoration(
        hintText: 'PIN code',
        hintStyle: const TextStyle(color: Colors.grey),
        errorText: errorText,
        suffixIcon: IconButton(
          icon: Icon(isObscure ? Icons.visibility : Icons.visibility_off),
          onPressed: onVisibilityToggle,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onChanged: onChanged,
    );
  }
}
