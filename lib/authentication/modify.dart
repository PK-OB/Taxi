import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_study0801/api/api.dart';
import 'package:flutter_study0801/model/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class EditProfilePage extends StatefulWidget {
  final String userId; // 사용자 ID를 받아오기 위한 생성자 인자 추가

  EditProfilePage({required this.userId}); // 생성자에서 사용자 ID 받기

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  var userNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  void updateUserProfile() async {
    final updatedData = {
      'user_id': widget.userId, // 사용자 ID를 함께 보내기
      'new_user_name': userNameController.text,
      'new_user_email': emailController.text,
      'new_user_password': passwordController.text,
    };

    final response = await http.post(
      Uri.parse(API.modifyUser),
      body: updatedData,
    );

    if (response.statusCode == 200) {
      // 수정 성공 시 처리
    } else {
      // 수정 실패 시 처리
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
              controller: emailController,
              decoration: InputDecoration(labelText: '이메일'),
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


