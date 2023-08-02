import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart' as Dartz;

class InputValidateType extends Equatable {
  @override
  List<Object?> get props => [];
}

class Invalid extends InputValidateType {
  final String errorMessage;

  Invalid(this.errorMessage);
}

class Valid extends InputValidateType {}

typedef OnValidate = Dartz.Either<Invalid, Valid> Function(String value);

typedef InputCondition = bool Function(String value);
