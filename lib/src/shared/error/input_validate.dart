import 'package:dartz/dartz.dart';
import 'package:ipacking_app/src/shared/error/reg_exp.dart';

import '../../../generated/l10n.dart';
import '../utils/valid_text_field.dart';


class InputValidate {
  const InputValidate();

  static Either<Invalid, Valid> commonValidate(String value) {
    return validateEmpty(value).fold((l) => Left(l), (r) => Right(r));
  }

  static Either<Invalid, Valid> validateEmpty(String value) {
    if (value.isEmpty) {
      return Left(Invalid(S.current.lbl_validate_empty));
    }
    return Right(Valid());
  }

  static Either<Invalid, Valid> validateEmail(String value) {
    bool emailValid = RegExpApp.validateEmail.hasMatch(value);
    if (emailValid) {
      return Right(Valid());
    }
    return Left(Invalid(S.current.lbl_validate_email));
  }

  static Either<Invalid, Valid> validateConfirmPassword(
      String value, String password, String confirmPassword
      ) {
    if(password == confirmPassword) {
      return Right(Valid());
    }
    return Left(Invalid(S.current.lbl_validate_confirm_password));
  }
  static Either<Invalid, Valid> validatePasswordLengthAndAlphabets(
      String value) {
    bool passwordValidLength = RegExpApp.validateCharacter.hasMatch(value);
    bool passwordValidAlphabets =
    RegExpApp.passwordValidAlphabets.hasMatch(value);
    if (passwordValidLength && passwordValidAlphabets) {
      return Right(Valid());
    } else {
      if (passwordValidLength == false) {
        return Left(Invalid(S.current.lbl_validate_password_short));
      } else {
        return Left(Invalid(S.current.lbl_validate_alphabet));
      }
    }
  }
}
