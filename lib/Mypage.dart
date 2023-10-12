import 'package:flutter/material.dart';
import 'package:flutter_study0801/authentication/modify.dart';
import 'package:flutter_study0801/authentication/modify_check.dart';
class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // 내 모집글 관리 페이지로 이동하는 코드를 추가하세요.
              },
              child: Text('내 모집글 관리'),
            ),
            ElevatedButton(
              onPressed: () {
                // 내 평점 및 후기 페이지로 이동하는 코드를 추가하세요.
              },
              child: Text('내 평점 및 후기'),
            ),
            ElevatedButton(
              onPressed: () {
                // 참여중인 모집글 페이지로 이동하는 코드를 추가하세요.
              },
              child: Text('참여중인 모집글'),
            ),
            ElevatedButton(
              onPressed: () {
                // 내 알람 관리 페이지로 이동하는 코드를 추가하세요.
              },
              child: Text('내 알람 관리'),
            ),
            ElevatedButton(
              onPressed: () {


              },
              child: Text('내 정보 수정'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 이전 페이지로 돌아가는 코드를 추가하세요.
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MyPage(),
  ));
}
