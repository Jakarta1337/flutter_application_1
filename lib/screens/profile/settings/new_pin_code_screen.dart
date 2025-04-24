import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_signup/screens/profile/settings/settings_screen.dart';

class NewPinCodeVerificationScreen extends StatefulWidget {
  const NewPinCodeVerificationScreen({super.key});

  @override
  State<NewPinCodeVerificationScreen> createState() =>
      _NewPinCodeVerificationScreenState();
}

class _NewPinCodeVerificationScreenState
    extends State<NewPinCodeVerificationScreen> {
  final TextEditingController _newPinController = TextEditingController();
  final TextEditingController _confirmPinController = TextEditingController();

  String? _newPinError;
  String? _confirmPinError;

  bool _obscureNewPin = true;
  bool _obscureConfirmPin = true;
  bool _isLoading = false;

  void _saveNewPin() async {
    final newPin = _newPinController.text;
    final confirmPin = _confirmPinController.text;

    setState(() {
      _newPinError = null;
      _confirmPinError = null;
    });

    if (newPin.isEmpty || newPin.length < 6) {
      setState(() {
        _newPinError = 'PIN must be 6 digits';
      });
      return;
    }

    if (confirmPin != newPin) {
      setState(() {
        _confirmPinError = 'PINs do not match';
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SettingsScreen()),
    );
  }

  @override
  void dispose() {
    _newPinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New PIN code')),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'The PIN must be 6 digits',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),

                    const SizedBox(height: 20),
                    TextField(
                      controller: _newPinController,
                      obscureText: _obscureNewPin,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6),
                      ],
                      decoration: InputDecoration(
                        labelText: 'New PIN code',
                        border: const OutlineInputBorder(),
                        errorText: _newPinError,
                        counterText: '',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureNewPin
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureNewPin = !_obscureNewPin;
                            });
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                    TextField(
                      controller: _confirmPinController,
                      obscureText: _obscureConfirmPin,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6),
                      ],
                      decoration: InputDecoration(
                        labelText: 'Confirm new PIN code',
                        border: const OutlineInputBorder(),
                        errorText: _confirmPinError,
                        counterText: '',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPin
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPin = !_obscureConfirmPin;
                            });
                          },
                        ),
                      ),
                    ),

                    const Spacer(),
                    ElevatedButton(
                      onPressed: _saveNewPin,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Save', style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              ),
    );
  }
}
