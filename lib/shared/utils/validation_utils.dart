// LAYER: Shared / Utils
// PURPOSE: Form validation helpers used in auth and data entry screens.
//          Return null on success, error string on failure — matches Flutter's validator signature.

class ValidationUtils {
  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final re = RegExp(r'^[\w\-.]+@[\w\-]+\.\w{2,}$');
    if (!re.hasMatch(value.trim())) return 'Enter a valid email address';
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? required(String? value, {String field = 'This field'}) {
    if (value == null || value.trim().isEmpty) return '$field is required';
    return null;
  }

  static String? positiveAmount(String? value) {
    if (value == null || value.isEmpty) return 'Amount is required';
    final n = double.tryParse(value);
    if (n == null || n <= 0) return 'Enter a valid amount greater than 0';
    return null;
  }
}
