import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_study0801/api/api.dart';
import 'package:flutter_study0801/model/alarm.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}


class _AlarmPageState extends State<AlarmPage> {
  var formKey = GlobalKey<FormState>();

  var userNameController = TextEditingController();
  var timeDepController = TextEditingController();
  var timeRoundController = TextEditingController();
  var locDepController = TextEditingController();
  var locArrController = TextEditingController();


  checkAlarm() async {


    try {
      var response = await http.post(Uri.parse(API.validateAlarm),
          body: {'al_time_dep':timeDepController.text.trim()});
          //body: {'user_name':user_name_Controller.text.trim()});
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['existAlarm'] == true) {
          Fluttertoast.showToast(
            msg: "이미 같은 시간의 알람이 존재합니다",
          );
        }else{
          Fluttertoast.showToast(
            msg: "saveInfo까지 갔음",
          );

          saveInfo();
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "오류 발생, 다시 시도해주세요",
      );
    }
  }

  saveInfo() async {
    Fluttertoast.showToast(msg: 'saveInfo진입완료');

    Alarm alarmModel = Alarm(
        1,
        userNameController.text.trim(),
        timeDepController.text.trim(),
        timeRoundController.text.trim(),
        locDepController.text.trim(),
        locArrController.text.trim(),
    );

    try {
      Fluttertoast.showToast(msg: 'try진입완료');

      var res = await http.post(
          Uri.parse(API.writeAlarm),
          body: alarmModel.toJson()
      );

      if(res.statusCode == 200){
        var resAlarm = jsonDecode(res.body);
        if(resAlarm['successAlarm'] == true){
          Fluttertoast.showToast(msg: '생성 완료');
          setState(() {
            userNameController.clear();
            timeDepController.clear();
            timeRoundController.clear();
            locDepController.clear();
            locArrController.clear();
          });
        }else{
          Fluttertoast.showToast(msg: '에러가 발생했습니다. 다시 시도해주세요.');
        }
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('알람 생성 완료1'),
            content: Text(''),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('확인'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.alarm,
                  color: Colors.deepPurple,
                  size: 100,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  '알람 생성',
                  style: GoogleFonts.bebasNeue(fontSize: 36.0),
                ),
                SizedBox(
                  height: 10,
                ),


                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: TextFormField(
                              controller: userNameController,
                              validator: (val) =>
                              val == "" ? "정보를 입력하세요" : null,
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: 'username'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: TextFormField(
                              controller: timeDepController,
                              validator: (val) =>
                              val == "" ? "정보를 입력하세요" : null,
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: '출발 시간'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: TextFormField(
                              controller: timeRoundController,
                              validator: (val) =>
                              val == "" ? "Please enter email" : null,
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: '왕복 시간'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: TextFormField(
                              controller: locDepController,
                              validator: (val) =>
                              val == "" ? "Please enter password" : null,
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: '출발 장소'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: TextFormField(
                              controller: locArrController,
                              validator: (val) =>
                              val == "" ? "Please enter password" : null,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '도착 장소'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {

                      checkAlarm();

                  },
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: Text(
                            '생성 완료',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('알람 생성을 완료하셨나요?'),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Text(
                        ' 돌아가기 ',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}