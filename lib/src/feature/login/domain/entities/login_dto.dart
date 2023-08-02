import 'package:equatable/equatable.dart';

class LoginDTO extends Equatable {
  final String _username;
  final String _password;

  const LoginDTO(this._username, this._password);

  String? get email => _username;

  String? get password => _password;

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["username"] = _username;
    map["password"] = _password;
    return map;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [_username, _password];
}
