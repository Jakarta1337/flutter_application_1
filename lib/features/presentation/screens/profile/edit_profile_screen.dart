import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/services.dart';

import 'package:login_signup/features/presentation/widgets/read_only_field.dart';
import 'package:login_signup/features/presentation/widgets/editable_field.dart';
import 'package:login_signup/features/presentation/widgets/image_picker_widget.dart';
import 'package:login_signup/features/presentation/widgets/validators.dart';

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
  final _formKey = GlobalKey<FormState>();

  late Map<String, dynamic> _updatedUserData;
  late TextEditingController _lastNameController;
  late TextEditingController _firstNameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _imageFile = widget.initialImage;
    _updatedUserData = Map.from(widget.userData);

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
    _lastNameController.dispose();
    _firstNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
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
                            child: const Icon(
                              Icons.add_a_photo,
                              size: 30,
                              color: Colors.blueAccent,
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
              buildEditableField(
                'Last Name',
                _lastNameController,
                validator: (value) => validateName(value!, 'Last name'),
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
                validator: (value) => validateName(value!, 'First name'),
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
                validator: (value) => validatePhone(value!),
                onChanged: (value) {
                  _updatedUserData['phone'] = value;
                },
                keyboardType: TextInputType.phone,
                inputFormatters: [LengthLimitingTextInputFormatter(16)],
              ),

              buildEditableField(
                'Email',
                _emailController,
                validator: (value) => validateEmail(value!),
                onChanged: (value) {
                  _updatedUserData['email'] = value;
                },
                keyboardType: TextInputType.emailAddress,
                inputFormatters: [LengthLimitingTextInputFormatter(25)],
              ),

              buildReadOnlyField('CIN', widget.userData['cin'] ?? 'AB123456'),

              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final result = {
                        'image': _imageFile,
                        'userData': _updatedUserData,
                      };
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
