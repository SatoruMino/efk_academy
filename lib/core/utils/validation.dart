import 'package:easy_localization/easy_localization.dart';
import 'package:efk_academy/core/core.dart';

class Validation {
  static String? emailError(EmailValidationError? error) {
    switch (error) {
      case EmailValidationError.invalid:
        return 'email_is_not_validated'.tr();
      default:
        return null;
    }
  }

  static String? passwordError(PasswordValidationError? error) {
    switch (error) {
      case PasswordValidationError.invalid:
        return 'password_is_not_validated'.tr();
      default:
        return null;
    }
  }

  static String? usernameError(UsernameValidateError? error) {
    switch (error) {
      case UsernameValidateError.empty:
        return 'please_enter_your_username'.tr();
      case UsernameValidateError.invalid:
        return 'username_is_not_validated'.tr();
      case UsernameValidateError.tooLong:
        return 'username_is_too_long'.tr();
      default:
        return null;
    }
  }
}
