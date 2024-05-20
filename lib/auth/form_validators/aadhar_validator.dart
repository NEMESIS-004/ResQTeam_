import 'package:formz/formz.dart';

enum AadharValidationError { empty, invalid }

class AadharNumber extends FormzInput<String, AadharValidationError> {
  const AadharNumber.pure() : super.pure('');
  const AadharNumber.dirty([String value = '']) : super.dirty(value);

  @override
  AadharValidationError? validator(String value) {
    if (value.isEmpty) {
      return AadharValidationError.empty;
    } else if (value.length < 12) {
      return AadharValidationError.invalid;
    } else {
      return null;
    }
  }

  static String? showAadharValidationError(AadharValidationError? error) {
    if (error == AadharValidationError.empty) {
      return 'Can\'t be emtpy';
    } else if (error == AadharValidationError.invalid) {
      return 'Invalid Aadhar Number';
    } else {
      return null;
    }
  }
}
