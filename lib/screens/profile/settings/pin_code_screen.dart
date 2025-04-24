import 'package:flutter/material.dart';
import 'package:login_signup/screens/profile/settings/new_pin_code_screen.dart';
import 'package:login_signup/widgets/settings/pin_code_field.dart';
import 'package:login_signup/widgets/create_button.dart';

class PinCodeVerificationScreen extends StatefulWidget {
  const PinCodeVerificationScreen({super.key});

  @override
  State<PinCodeVerificationScreen> createState() =>
      _PinCodeVerificationScreenState();
}

class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
  final TextEditingController _pinController = TextEditingController();
  String _staticPinCode = '000000';
  bool _isObscure = true;
  String? _errorText;
  bool _isLoading = false;

  void _validatePin() async {
    if (_pinController.text.isEmpty) {
      setState(() {
        _updateErrorText('PIN code cannot be empty');
      });
      return;
    }

    if (_pinController.text == _staticPinCode) {
      setState(() {
        _isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 1));

      if (!mounted) return;
      final newPin = await Navigator.push<String>(
        context,
        MaterialPageRoute(
          builder: (context) => const NewPinCodeVerificationScreen(),
        ),
      );

      if (!mounted) return;
      // if (newPin != null && newPin.isNotEmpty) {
      if (newPin?.isNotEmpty ?? false) {
        setState(() {
          _staticPinCode = newPin!;
          _pinController.clear();
          _errorText = null;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('PIN code updated successfully')),
        );
      }

      setState(() {
        _isLoading = false;
      });
    } else {
      _updateErrorText('Incorrect PIN code');
    }
  }

  void _updateErrorText(String message) {
    if (mounted) {
      setState(() {
        _errorText = message;
      });
    }
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify it\'s you')),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'For your security, re-enter your code PIN to continue.',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),

                              const SizedBox(height: 20),
                              PinCodeField(
                                controller: _pinController,
                                isObscure: _isObscure,
                                errorText: _errorText,
                                onChanged: (value) {
                                  if (_errorText != null) {
                                    setState(() => _errorText = null);
                                  }
                                },
                                onVisibilityToggle: () {
                                  setState(() => _isObscure = !_isObscure);
                                },
                              ),
                            ],
                          ),
                        ),
                        ContinueButton(
                          onPressed: _validatePin,
                          title: 'Continue',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}
