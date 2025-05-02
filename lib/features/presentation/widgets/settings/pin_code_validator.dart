import 'package:flutter/material.dart';
import 'package:login_signup/features/presentation/screens/profile/settings/new_pin_code_screen.dart';

class PinCodeValidator {
  final TextEditingController pinController;
  final BuildContext context;
  String staticPinCode = '000000';
  String? errorText;
  bool isLoading = false;

  PinCodeValidator({required this.pinController, required this.context});

  Future<void> validatePin(Function setState) async {
    if (pinController.text.isEmpty) {
      setErrorText(setState, 'PIN code cannot be empty');
      return;
    }

    if (pinController.text == staticPinCode) {
      setState(() {
        isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 1));

      // if (!mounted) return;
      final newPin = await Navigator.push<String>(
        context,
        MaterialPageRoute(
          builder: (context) => const NewPinCodeVerificationScreen(),
        ),
      );

      // if (!mounted) return;

      if (newPin?.isNotEmpty ?? false) {
        setState(() {
          staticPinCode = newPin!;
          pinController.clear();
          errorText = null;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('PIN code updated successfully')),
        );
      }

      setState(() {
        isLoading = false;
      });
    } else {
      setErrorText(setState, 'Incorrect PIN code');
    }
  }

  void setErrorText(Function setState, String message) {
    // if (mounted) {
      setState(() {
        errorText = message;
      });
    // }
  }
}
