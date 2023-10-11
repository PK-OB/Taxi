class Post{
  int rec_num;
  String user_name;
  String rec_loc_dep;
  String rec_loc_arr;
  String rec_select;
  String rec_time_dep;
  String rec_time_round;


  Post(
      this.rec_num,
      this.user_name,
      this.rec_loc_dep,
      this.rec_loc_arr,
      this.rec_select,
      this.rec_time_dep,
      this.rec_time_round,

      );

  Map<String, dynamic> toJson() => {
    'rec_num' : rec_num.toString(),
    'user_name' : user_name,
    'rec_loc_dep' : rec_loc_dep,
    'rec_loc_arr' : rec_loc_arr,
    'rec_select' : rec_select,
    'rec_time_dep' : rec_time_dep,
    'rec_time_round' : rec_time_round,
  };
}