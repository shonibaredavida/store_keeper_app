class Validation {
  bool? validatePassword(String? value) {
    if (value == null) return false;
    if (value.isEmpty) return false;

    final isPasswordValid = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$',
    ).hasMatch(value);

    return isPasswordValid ? true : false;
  }

  bool? hasAdequateXters(String? value) {
    if (value == null) return false;
    return value.length >= 8;
  }

  bool? hasLower(String? value) {
    if (value == null) return false;
    return RegExp(r'[a-z]').hasMatch(value);
  }

  bool? hasUpper(String? value) {
    if (value == null) return false;
    return RegExp(r'[A-Z]').hasMatch(value);
  }

  bool? hasSymbol(String? value) {
    if (value == null) return false;
    return RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(value);
  }

  bool? hasNumber(String? value) {
    if (value == null) return false;
    return RegExp(r'[0-9]').hasMatch(value);
  }

  bool? validateEmail(String? email) {
    if (email == null) return false;
    if (email.isEmpty) return false;

    final isEmailValid = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(email.trim());

    return isEmailValid ? true : false;
  }
}
