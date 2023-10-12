import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_study0801/api/api.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class ModifyPage extends StatefulWidget {
  final String userEmail;

  ModifyPage({required this.userEmail});

  @override
  State<ModifyPage> createState() => _ModifyPageState();
}

class _ModifyPageState extends State<ModifyPage> {
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();

  void updateUserProfile() async {
    final updatedData = {
      'user_email': widget.userEmail, // 사용자 이메일을 함께 보내기
      'user_name': userNameController.text, // 기존 키로 수정
      'user_pw': passwordController.text, // 기존 키로 수정
    };

    final response = await http.post(
      Uri.parse(API.modifyUser),
      body: updatedData,
    );

    if (response.statusCode == 200) {
      // 수정 성공 시 처리
      Fluttertoast.showToast(
        msg: "사용자 정보가 수정되었습니다.",
      );
    } else {
      // 수정 실패 시 처리
      Fluttertoast.showToast(
        msg: "사용자 정보 수정 중 문제가 발생했습니다.",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('프로필 수정'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: userNameController,
              decoration: InputDecoration(labelText: '아이디'),
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(labelText: '비밀번호'),
            ),
            ElevatedButton(
              onPressed: () {
                updateUserProfile();
              },
              child: Text('저장'),
            ),
          ],
        ),
      ),
    );
  }
}
