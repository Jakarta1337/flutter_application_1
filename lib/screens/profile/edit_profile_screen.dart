import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/services.dart';

import 'package:login_signup/widgets/read_only_field.dart';
import 'package:login_signup/widgets/editable_field.dart';
import 'package:login_signup/widgets/image_picker_widget.dart';

// Updated EditProfileScreen with comprehensive field validation
class EditProfileScreen extends StatefulWidget {
  final File? initialImage;
  final Map<String, dynamic> userData;

  const EditProfileScreen({
    super.key,
    this.initialImage,
    required this.userData,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _imageFile;

  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // Text editing controllers to manage field values
  late TextEditingController _lastNameController;
  late TextEditingController _firstNameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;

  // Map to hold updated user data
  late Map<String, dynamic> _updatedUserData;

  @override
  void initState() {
    super.initState();
    _imageFile = widget.initialImage;

    // Initialize the updated user data with the original data
    _updatedUserData = Map.from(widget.userData);

    // Initialize controllers with values from user data
    _lastNameController = TextEditingController(
      text: widget.userData['lastName'] ?? '',
    );
    _firstNameController = TextEditingController(
      text: widget.userData['firstName'] ?? '',
    );
    _phoneController = TextEditingController(
      text: widget.userData['phone'] ?? '',
    );
    _emailController = TextEditingController(
      text: widget.userData['email'] ?? '',
    );
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is disposed
    _lastNameController.dispose();
    _firstNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  // Function to validate a name (first or last)
  bool isValidName(String name) {
    if (name.isEmpty) {
      return false;
    }

    if (name.length < 2 || name.length > 25) {
      return false;
    }

    // Allow letters, spaces, hyphens, and apostrophes
    final RegExp nameRegex = RegExp(r"^[a-zA-Z\s\-']+$");
    return nameRegex.hasMatch(name);
  }

  // Function to validate a phone number
  bool isValidPhone(String phone) {
    if (phone.isEmpty) {
      return false;
    }

    // Validate format: optional single '+' at start, followed by 8-15 digits
    final RegExp phoneRegex = RegExp(r'^\+?[0-9]{8,15}$');

    return phoneRegex.hasMatch(phone);
  }

  // Function to validate an email address
  bool isValidEmail(String email) {
    if (email.isEmpty) {
      return false;
    }

    // Simple email regex that validates common email formats
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Personnel Information'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        child: ImagePickerWidget(
                          onImageSelected: (File image) {
                            setState(() {
                              _imageFile = image;
                            });
                          },
                        ),
                      );
                    },
                  );
                },
                child:
                    _imageFile == null
                        ? DottedBorder(
                          borderType: BorderType.Circle,
                          dashPattern: [6, 3],
                          color: Colors.grey,
                          strokeWidth: 2,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[200],
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo,
                                  size: 30,
                                  color: Colors.blueAccent,
                                ),
                              ],
                            ),
                          ),
                        )
                        : Stack(
                          children: [
                            ClipOval(
                              child: Image.file(
                                _imageFile!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _imageFile = null;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.7),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    size: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
              ),
              const SizedBox(height: 25),

              // Editable Fields with comprehensive validation
              buildEditableField(
                'Last Name',
                _lastNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Last name is required';
                  }
                  if (!isValidName(value)) {
                    return 'Please enter a valid last name';
                  }
                  return null;
                },
                onChanged: (value) {
                  _updatedUserData['lastName'] = value;
                },
                keyboardType: TextInputType.name,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z\s\-']")),
                  LengthLimitingTextInputFormatter(25),
                ],
              ),

              buildEditableField(
                'First Name',
                _firstNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'First name is required';
                  }
                  if (!isValidName(value)) {
                    return 'Please enter a valid first name';
                  }
                  return null;
                },
                onChanged: (value) {
                  _updatedUserData['firstName'] = value;
                },
                keyboardType: TextInputType.name,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z\s\-']")),
                  LengthLimitingTextInputFormatter(25),
                ],
              ),

              buildReadOnlyField(
                'Job',
                widget.userData['job'] ?? 'Front-end & Flutter Developer',
              ),

              buildEditableField(
                'Phone',
                _phoneController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone number is required';
                  }
                  if (!isValidPhone(value)) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
                onChanged: (value) {
                  _updatedUserData['phone'] = value;
                },
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(16),
                  TextInputFormatter.withFunction((oldValue, newValue) {
                    final text = newValue.text;

                    if (text.isEmpty) {
                      return newValue;
                    }

                    if (text.contains('+') && text.indexOf('+') > 0) {
                      return oldValue;
                    }

                    if (text.split('+').length > 2) {
                      return oldValue;
                    }

                    if (!RegExp(r'^\+?[0-9]*$').hasMatch(text)) {
                      return oldValue;
                    }

                    return newValue;
                  }),
                ],
              ),

              buildEditableField(
                'Email',
                _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  if (!isValidEmail(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                onChanged: (value) {
                  _updatedUserData['email'] = value;
                },
                keyboardType: TextInputType.emailAddress,
                inputFormatters: [LengthLimitingTextInputFormatter(25)],
              ),

              buildReadOnlyField('CIN', widget.userData['cin'] ?? 'AB123456'),
              const SizedBox(height: 30),

              // Save Button with validation
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Validate the form first
                    if (_formKey.currentState!.validate()) {
                      // Create result map with both image and updated data
                      final result = {
                        'image': _imageFile,
                        'userData': _updatedUserData,
                      };
                      // Return both the selected image and updated user data
                      Navigator.pop(context, result);
                    }
                  },
                  child: const Text('Save Changes'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
