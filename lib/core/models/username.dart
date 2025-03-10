import 'package:formz/formz.dart';

enum UsernameValidateError { empty, invalid, tooLong }

class Username extends FormzInput<String, UsernameValidateError> {
  const Username.pure([super.value = '']) : super.pure();
  const Username.dirty([super.value = '']) : super.dirty();

  @override
  UsernameValidateError? validator(String value) {
    if (value.isEmpty) {
      return UsernameValidateError.empty;
    }

    if (value.length < 3) {
      return UsernameValidateError.invalid;
    }

    if (value.length > 10) {
      return UsernameValidateError.tooLong;
    }

    return null;
  }
}
