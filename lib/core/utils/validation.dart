import 'package:easy_localization/easy_localization.dart';

extension Validation on String {
  static String? validateUsername(String value) {
    if (value.isEmpty || value == '') {
      return 'សូមធ្វើការបំពេញឈ្មោះរបស់អ្នក!';
    } else if (value.length < 2) {
      return 'ឈ្មោះត្រូវមានចំនួនតួអក្សរយ៉ាងតិច ២ តួ!';
    } else {
      return null;
    }
  }

  static String? validateEmail(String value) {
    String pattern =
        r'^[a-zA-Z0-9.a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty || value == '') {
      return tr('validation.please_enter_your_email');
    } else if (!regExp.hasMatch(value)) {
      return tr('validation.email_is_not_validated');
    } else {
      return null;
    }
  }

  static String? validatePassword(String value) {
    String pattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$';

    RegExp regExp = RegExp(pattern);
    if (value == '' || value.isEmpty) {
      return tr('validation.please_enter_your_password');
    } else if (!regExp.hasMatch(value)) {
      return tr('validation.password_is_not_validated');
    } else {
      return null;
    }
  }
}
