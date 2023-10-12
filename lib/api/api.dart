class API{
  static const hostConnect = "http://192.168.0.100/api_app";
  static const hostConnectUser = "$hostConnect/user";


  //127.0.0.1
  static const signup = "$hostConnect/user/signup.php";
  static const validateEmail = "$hostConnect/user/validate_email.php";

  static const login = "$hostConnect/user/login.php";


  static const writeAlarm = "$hostConnect/user/write_alarm.php";
  static const validateAlarm = "$hostConnect/user/validate_alarm.php";

  static const writePost = "$hostConnect/user/write_post.php";
  static const validatePost = "$hostConnect/user/validate_post.php";

  static const checkUserByEmail = "$hostConnect/user/check_user_by_email.php";

  static const modifyUser = "$hostConnect/user/modify_user.php";


}