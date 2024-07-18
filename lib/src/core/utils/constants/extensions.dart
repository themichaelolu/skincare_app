// ignore_for_file: public_member_api_docs,, unnecessary_this

extension ValidatorX on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName {
    final nameRegExp = RegExp('[a-zA-Z]');
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');
    return passwordRegExp.hasMatch(this);
  }

  bool  get hasSpaceAndFollowingChars {
  return split(' ').length > 1;
}
    String anonymizeEmail() {
    // Find the positions of the first '@' and the last '.' in the email
    final atIndex = indexOf('@');
    final dotIndex = lastIndexOf('.');

    // Ensure valid email format with both '@' and '.' present
    if (atIndex >= 0 && dotIndex > atIndex) {
      // Get the portion of the email to anonymize
      final substring =this. substring(0, atIndex);
      final afterAt=this.substring(atIndex,this.length);
      /// Get second character to secon  to last character
      final secondCharacterTseconToLastCharacter=substring.substring(1,substring.length-1);
      // Replace each character in the substring with 'x'
      final anonymizedSubstring = secondCharacterTseconToLastCharacter.replaceAll(RegExp('.'), 'x');

      // Construct the anonymized email by combining parts
      return this.substring(0, 1) + anonymizedSubstring.substring(0,4)+substring.substring(substring.length-1, substring.length) +afterAt;
      // return anonymizedSubstring+""+afterAt;
    } else {
      // If invalid format, return the original string
      return this;
    }
  }


  

  bool get isValidPhone {
    final phoneRegExp = RegExp(r'^\+?0[0-9]{10}$');

    return phoneRegExp.hasMatch(this);
  }

  bool get isValidNumber {
    final numReg = RegExp(r'^[0-9]+$');

    return numReg.hasMatch(this);
  }
}
