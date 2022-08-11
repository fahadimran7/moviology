class InputValidators {
  static validateEmailAddress(email) {
    if (email == null || email.isEmpty) {
      return 'Email Address cannot be empty';
    }

    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      return 'Enter a valid Email Address';
    }
    return null;
  }

  static validatePassword(password) {
    if (password == null || password.isEmpty) {
      return 'Password cannot be empty';
    }

    if (password.length < 6) {
      return "Password must be 6 characters";
    }
    return null;
  }

  static validateConfirmPassword(confirmPassword, password) {
    if (confirmPassword == null ||
        confirmPassword.isEmpty ||
        confirmPassword != password.text) {
      return 'Passwords do not match';
    }

    return null;
  }

  static validateFullName(name) {
    if (name == null || name.isEmpty) {
      return 'Name cannot be empty';
    }
    return null;
  }

  static validateSearch(name) {
    if (name == null || name.isEmpty) {
      return 'Type something or select a genre';
    }
    return null;
  }

  static validateMobileNumber(number) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(patttern);
    if (number.length == 0) {
      return 'Mobile cannot be empty';
    } else if (!regExp.hasMatch(number)) {
      return 'Enter a valid mobile number';
    }
    return null;
  }
}
