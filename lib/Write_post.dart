/*
class CreatePostPage extends StatelessWidget {
  final Function(Post) onPostCreated;

  CreatePostPage({required this.onPostCreated});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('글 작성'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: '제목'),
            ),
            SizedBox(height: 8),
            TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: '내용'),
            ),
            SizedBox(height: 8),
            TextField(
              controller: timeController,
              decoration: InputDecoration(labelText: '시간'),
            ),
            SizedBox(height: 8),
            TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: '장소'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                String title = titleController.text;
                String content = contentController.text;
                String time = timeController.text;
                String location = locationController.text;

                if (title.isNotEmpty && content.isNotEmpty && time.isNotEmpty && location.isNotEmpty) {
                  Post newPost = Post(title, content, time, location);
                  onPostCreated(newPost);
                  Navigator.pop(context); // 작성 완료 후 페이지 닫기
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Error'),
                      content: Text('모든 필드를 입력하세요.'),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text('글 등록'),
            ),
          ],
        ),
      ),
    );
  }
}
*/






// 작성 ui
/*
class CreatePostPage extends StatefulWidget {
  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController departureController = TextEditingController();
  final TextEditingController arrivalController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController roundTripTimeController = TextEditingController();
  final TextEditingController commentController = TextEditingController();

  bool isRoundTrip = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('글 작성'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: departureController,
                    decoration: InputDecoration(labelText: '출발 장소'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.map),
                  onPressed: () async {
                    Post? newPost = await Get.to(() => MyApp());
                  },
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: arrivalController,
                    decoration: InputDecoration(labelText: '도착 장소'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.map),
                  onPressed: () async {
                    Post? newPost = await Get.to(() => MyApp());
                  },
                ),
              ],
            ),
            SizedBox(height: 8),
            TextField(
              controller: timeController,
              decoration: InputDecoration(labelText: '출발 시간'),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text('편도'),
                Radio<bool>(
                  value: false,
                  groupValue: isRoundTrip,
                  onChanged: (value) {
                    setState(() {
                      isRoundTrip = value!;
                    });
                  },
                ),
                Text('왕복'),
                Radio<bool>(
                  value: true,
                  groupValue: isRoundTrip,
                  onChanged: (value) {
                    setState(() {
                      isRoundTrip = value!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 8),
            TextField(
              controller: roundTripTimeController,
              decoration: InputDecoration(
                labelText: '왕복 시간',
                enabled: isRoundTrip,
              ),
              enabled: isRoundTrip,
            ),
            SizedBox(height: 8),
            TextField(
              controller: commentController,
              decoration: InputDecoration(labelText: '코멘트'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                String departure = departureController.text;
                String arrival = arrivalController.text;
                String time = timeController.text;
                String roundTripTime = roundTripTimeController.text;
                String comment = commentController.text;

                if (departure.isNotEmpty &&
                    arrival.isNotEmpty &&
                    time.isNotEmpty &&
                    comment.isNotEmpty) {
                  Post newPost = Post(
                    departure,
                    arrival,
                    time,
                    isRoundTrip,
                    roundTripTime,
                    comment,
                  );
                  Navigator.pop(context, newPost); // 작성 완료 후 페이지 닫기
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Error'),
                      content: Text('모든 필드를 입력하세요.'),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text('글 등록'),
            ),
          ],
        ),
      ),
    );
  }
}
*/


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_study0801/api/api.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_study0801/model/post.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter_study0801/kakaomap/kakao_map.dart';


class CreatePostPage extends StatefulWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  var formKey = GlobalKey<FormState>();
  var user_name_Controller= TextEditingController();
  var rec_loc_dep_Controller= TextEditingController();
  var rec_loc_arr_Controller = TextEditingController();
  var rec_select_Controller = TextEditingController();
  var rec_time_dep_Controller = TextEditingController();
  var rec_time_round_Controller = TextEditingController();


  checkPost() async {
    try {
      var response = await http.post(Uri.parse(API.validatePost),
          body: {'user_name': user_name_Controller.text.trim()});

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['existPost'] == true) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('작성 실패'),
                content: Text('이미 모집글을 작성하였습니다'),
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
        }else{
          saveInfo();
        }
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('오류메세지'),
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

  saveInfo() async {
    Post postModel = Post(
        1,
        user_name_Controller.text.trim(),
        rec_loc_dep_Controller.text.trim(),
        rec_loc_arr_Controller.text.trim(),
        rec_select_Controller.text.trim(),
        rec_time_dep_Controller.text.trim(),
        rec_time_round_Controller.text.trim()
    );

    try {
      var res = await http.post(
          Uri.parse(API.writePost),
          body: postModel.toJson()
      );

      if(res.statusCode == 200){
        var resSignup = jsonDecode(res.body);
        if(resSignup['success'] == true){
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('모집글 작성 완료'),
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
          setState(() {
            user_name_Controller.clear();
            rec_loc_dep_Controller.clear();
            rec_loc_arr_Controller.clear();
            rec_select_Controller.clear();
            rec_time_dep_Controller.clear();
            rec_time_round_Controller.clear();
          });
        }else{
          Fluttertoast.showToast(msg: '오류 발생. 다시 시도해주십시오');
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
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
                  Icons.card_travel_outlined,
                  color: Colors.deepPurple,
                  size: 100,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  '모집글 작성',
                  style: GoogleFonts.bebasNeue(fontSize: 36.0),
                ),
                SizedBox(
                  height: 50,
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
                              controller: user_name_Controller,
                              validator: (val) =>
                              val == "" ? "아이디를 입력해주세요 " : null,
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: '아이디'),
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
                              controller: rec_loc_dep_Controller,
                              validator: (val) =>
                              val == "" ? "출발 장소를 입력해주세요" : null,
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
                              controller: rec_loc_arr_Controller,
                              validator: (val) =>
                              val == "" ? "도착 장소를 입력해주세요" : null,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '도착 장소'),
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
                              controller: rec_select_Controller,
                              validator: (val) =>
                              val == "" ? "편도/왕복 여부" : null,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '편도/왕복'),
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
                              controller: rec_time_dep_Controller,
                              validator: (val) =>
                              val == "" ? "출발 시간을 입력해주세요" : null,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '출발 시간'),
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
                              controller: rec_time_round_Controller,
                              validator: (val) =>
                              val == "" ? "왕복 시간을 입력해주세요" : null,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '왕복 시간'),
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
                       checkPost();
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
                            '생성하기',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}