class User{
  int user_num;
  String user_name;
  String user_email;
  String user_pw;

  User(this.user_num, this.user_name, this.user_email, this.user_pw);

  Map<String, dynamic> toJson() => {
    'user_num' : user_num.toString(),
    'user_name' : user_name,
    'user_email' : user_email,
    'user_pw' : user_pw
  };
}