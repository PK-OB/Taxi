class LoginData {
  String user_email;
  String user_password;

  LoginData(this.user_email, this.user_password);

  Map<String, dynamic> toJson() => {
    'user_email': user_email,
    'user_password': user_password,
  };
}
