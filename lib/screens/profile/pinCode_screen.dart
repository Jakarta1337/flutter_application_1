import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_signup/screens/profile/newPinCode_screen.dart';

class PinCodeVerificationScreen extends StatefulWidget {
  const PinCodeVerificationScreen({Key? key}) : super(key: key);

  @override
  _PinCodeVerificationScreenState createState() =>
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
        _errorText = 'PIN code cannot be empty';
      });
      return;
    }

    if (_pinController.text == _staticPinCode) {
      setState(() {
        _isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 1));

      final newPin = await Navigator.push<String>(
        context,
        MaterialPageRoute(
          builder: (context) => const NewPinCodeVerificationScreen(),
        ),
      );

      if (newPin != null && newPin.isNotEmpty) {
        setState(() {
          _staticPinCode = newPin;
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
      setState(() {
        _errorText = 'Incorrect PIN code';
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
                              TextField(
                                controller: _pinController,
                                obscureText: _isObscure,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(6),
                                ],
                                decoration: InputDecoration(
                                  hintText: 'PIN code',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  errorText: _errorText,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _isObscure
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isObscure = !_isObscure;
                                      });
                                    },
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onChanged: (value) {
                                  if (_errorText != null) {
                                    setState(() {
                                      _errorText = null;
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _validatePin,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Continue',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}
