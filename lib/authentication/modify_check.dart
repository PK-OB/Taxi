import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_study0801/api/api.dart';
import 'package:flutter_study0801/authentication/modify.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class ModifyCheckPage extends StatefulWidget {
  @override
  State<ModifyCheckPage> createState() => _ModifyCheckPageState();
}

class _ModifyCheckPageState extends State<ModifyCheckPage> {
  var userEmailController = TextEditingController();

  void checkUserAndNavigate() async {
    final userEmail = userEmailController.text;

    final response = await http.post(
      Uri.parse(API.checkUserByEmail),
      body: {'user_email': userEmail},
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['userFound'] == true) {
        // 사용자 정보가 찾아졌을 때, 수정 페이지로 이동
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ModifyPage(userEmail: userEmail),
          ),
        );
      } else {
        Fluttertoast.showToast(
          msg: "해당 이메일의 사용자를 찾을 수 없습니다.",
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "서버와 통신 중 문제가 발생했습니다.",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('정보 수정 확인'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: userEmailController,
              decoration: InputDecoration(labelText: '이메일'),
            ),
            ElevatedButton(
              onPressed: () {
                checkUserAndNavigate();
              },
              child: Text('내 정보 수정'),
            ),
          ],
        ),
      ),
    );
  }
}
