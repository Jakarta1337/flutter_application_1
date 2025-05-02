String? validateName(String value, String fieldName) {
  if (value.isEmpty) return '$fieldName is required';
  if (!RegExp(r"^[a-zA-Z\s\-']+$").hasMatch(value)) {
    return 'Please enter a valid $fieldName';
  }
  return null;
}

String? validatePhone(String value) {
  if (value.isEmpty) return 'Phone number is required';
  if (!RegExp(r'^\+?[0-9]{8,15}$').hasMatch(value)) {
    return 'Please enter a valid phone number';
  }
  return null;
}

String? validateEmail(String value) {
  if (value.isEmpty) return 'Email is required';
  if (!RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  ).hasMatch(value)) {
    return 'Please enter a valid email address';
  }
  return null;
}

