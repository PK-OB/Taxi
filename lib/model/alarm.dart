class Alarm{
  int alarm_num;
  String user_name;
  String alarm_time_dep;
  String alarm_time_round;
  String alarm_loc_dep;
  String alarm_loc_arr;
  String alarm_del_time;

  Alarm(
      this.alarm_num,
      this.user_name,
      this.alarm_time_dep,
      this.alarm_time_round,
      this.alarm_loc_dep,
      this.alarm_loc_arr,
      this.alarm_del_time);

  Map<String, dynamic> toJson() => {
    'alarm_num' : alarm_num.toString(),
    'user_name' : user_name,
    'alarm_time_dep' : alarm_time_dep,
    'alarm_time_round' : alarm_time_round,
    'alarm_loc_dep' : alarm_loc_dep,
    'alarm_loc_arr' : alarm_loc_arr,
    'alarm_del_time' : alarm_del_time
  };
}