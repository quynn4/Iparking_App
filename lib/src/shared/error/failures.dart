import 'package:equatable/equatable.dart';

import '../../../generated/l10n.dart';


abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

class NoNetworkError extends Failure {
  NoNetworkError() : super(S.current.lbl_no_network);
}

class CacheFailure extends Failure {
  const CacheFailure(String message) : super(message);
}
