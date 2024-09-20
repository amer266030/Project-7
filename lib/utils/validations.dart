class Validations {
  static String? emptyFieldValidation(String value) {
    final regex = RegExp(r'^[a-zA-Z\s]+$');
    if (regex.hasMatch(value) || value.isEmpty) {
      // Valid email address
      return null;
    } else {
      // Invalid email address
      return 'This Field Cannot be Empty';
    }
  }

  static String? email(String value) {
    final regex = RegExp(r"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}");
    if (regex.hasMatch(value)) {
      return null; // Return null if the value is valid (no error)
    } else {
      return 'Please enter a valid email address'; // Return an error message if invalid
    }
  }

  static String? none(String value) => null;
}
