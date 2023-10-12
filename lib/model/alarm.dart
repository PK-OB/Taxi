class Alarm{
  int al_num;
  String user_name;
  String al_time_dep;
  String al_time_round;
  String al_loc_dep;
  String al_loc_arr;

  Alarm(
      this.al_num,
      this.user_name,
      this.al_time_dep,
      this.al_time_round,
      this.al_loc_dep,
      this.al_loc_arr,
);

  Map<String, dynamic> toJson() => {
    'al_num' : al_num.toString(),
    'user_name' : user_name,
    'al_time_dep' : al_time_dep,
    'al_time_round' : al_time_round,
    'al_loc_dep' : al_loc_dep,
    'al_loc_arr' : al_loc_arr,

  };
}