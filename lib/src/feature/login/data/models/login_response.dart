class LoginResponse {
  String? identifier;
  int? expiresIn;
  String? token;

  LoginResponse({this.identifier, this.expiresIn, this.token});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    identifier = json['Identifier'];
    expiresIn = json['Expires_In'];
    token = json['Token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Identifier'] = identifier;
    data['Expires_In'] = expiresIn;
    data['Token'] = token;
    return data;
  }
}