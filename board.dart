
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:taxi2023/Mypage.dart';
import 'package:taxi2023/Write_Map.dart';
import 'package:taxi2023/Write_rec.dart';
import 'package:taxi2023/kakaomap/kakao_map.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'post.dart';
import 'Write_Alarm.dart';
import 'package:taxi2023/authentication/login.dart';
import 'package:taxi2023/api/api.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';




class Recruit {
  final int recNum;
  final String recTimeDep;
  final String recTimeRound;
  final String recLocDep;
  final String recLocArr;
  final String recUser;

  Recruit(
      this.recNum,
      this.recTimeDep,
      this.recTimeRound,
      this.recLocDep,
      this.recLocArr,
      this.recUser,
      );
}

Future<List<Recruit>> fetchRecruits() async {
  final response = await http.get(Uri.parse(API.viewRec));

  if (response.statusCode == 200) {
    List<Recruit> recruits = [];

    // JSON 데이터를 파싱합니다.
    List<dynamic> data = jsonDecode(response.body);
    for (var item in data) {
      recruits.add(Recruit(
        int.parse(item['rec_num']), // 'rec_num' 필드를 정수로 파싱
        item['rec_time_dep'],
        item['rec_time_round'],
        item['rec_loc_dep'],
        item['rec_loc_arr'],
        item['rec_user'],
      ));
    }

    return recruits;
  } else {
    throw Exception('오류 발생');
  }
}

class BoardPage extends StatefulWidget {
  @override
  _BoardPageState createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  late Future<List<Recruit>> recruits;

  @override
  void initState() {
    super.initState();
    recruits = fetchRecruits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('게시판'),
      ),
      body: FutureBuilder<List<Recruit>>(
        future: recruits,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final recruit = snapshot.data![index];
                return Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text('모집글 번호: ${recruit.recNum}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('출발 장소: ${recruit.recLocDep}'),
                            Text('도착 장소: ${recruit.recLocArr}'),
                            SizedBox(height: 4),
                            Text('출발 시간: ${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(recruit.recTimeDep))}'),
                            Text('왕복 시간: ${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(recruit.recTimeRound))}'),
                            Text('모집자: ${recruit.recUser}'),
                          ],
                        ),
                      ),



                      ElevatedButton(
                        onPressed: () async {

                          try {
                            //현재 접속중인 사용자
                            final userEmail = globalUserEmail; // 사용자 이메일 가져오기

                            //선택한 모집글의 모집자
                            final recUser = recruit.recUser; // 모집글 번호 가져오기

                            final response = await http.post(
                              Uri.parse(API.joinRecruit), // PHP 파일 경로(API.joinRecruit)를 설정해야 합니다.
                              body: {
                                'user_email': userEmail,
                                'rec_user': recUser
                              },
                            );

                            Fluttertoast.showToast(msg: '중간 확인 - 사용자, 모집자: $userEmail, $recUser');

                            if (response.statusCode == 200) {
                              var result = jsonDecode(response.body);
                              final message = result['message'];
                              if (message == 'parting') {
                                Fluttertoast.showToast(msg: '이미 참여 중입니다.');
                              } else if (message == 'success') {
                                Fluttertoast.showToast(msg: '참여에 성공했습니다.');
                              } else {
                                // 정상적인 JSON 응답이 아닐 경우, 응답 내용을 로그로 출력
                                Fluttertoast.showToast(msg: '오류');
                              }
                            } else {
                              Fluttertoast.showToast(msg: '${response.statusCode}');
                            }
                          } catch (e) {
                            // 예외 발생 시, 예외 메시지를 로그로 출력
                            Fluttertoast.showToast(msg: '오류 발생: $e');
                          }
                        },
                        child: Text('참여하기'),
                      ),



                    ],
                  ),
                );
              },
            );
          }
          return Text('No data found');
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Text(
            '사용자: $globalUserEmail',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment(
              Alignment.bottomRight.x,
              Alignment.bottomRight.y - 0.2,
            ),
            child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () async {
                Get.to(() => CreateRecPage());
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              child: Icon(Icons.alarm),
              onPressed: () async {
                Get.to(() => AlarmPage());
              },
            ),
          ),
          Align(
            alignment: Alignment(
              Alignment.bottomRight.x,
              Alignment.bottomRight.y - 0.4,
            ),
            child: FloatingActionButton(
              child: Icon(Icons.assistant_photo),
              onPressed: () async {
                Post? newPost = await Get.to(() => MyApp());
              },
            ),
          ),
          Align(
            alignment: Alignment(
              Alignment.bottomRight.x,
              Alignment.bottomRight.y - 0.6,
            ),
            child: FloatingActionButton(
              child: Icon(Icons.loop),
              onPressed: () async {
                Post? newPost = await Get.to(() => MyApp1());
              },
            ),
          ),
          Align(
            alignment: Alignment(
              Alignment.bottomRight.x,
              Alignment.bottomRight.y - 0.8,
            ),
            child: FloatingActionButton(
              child: Icon(Icons.person_pin),
              onPressed: () async {
                Get.to(() => MyPage());
              },
            ),
          ),
        ],
      ),
    );
  }
}








