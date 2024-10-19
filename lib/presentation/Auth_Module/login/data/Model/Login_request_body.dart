class LoginRequestBodyModel{
  final String email;
  final String password;

  LoginRequestBodyModel({required this.email, required this.password});

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password
  };
}