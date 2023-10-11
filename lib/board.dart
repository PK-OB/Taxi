
/*
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_study0801/api/api.dart';
import 'package:flutter_study0801/model/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';


class Post {
  final String title;
  final String content;
  final String time;
  final String location;

  Post(this.title, this.content, this.time, this.location);
}

class Board extends StatefulWidget {
  const Board({Key? key}) : super(key: key);

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  List<Post> posts = [];
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final timeController = TextEditingController();
  final locationController = TextEditingController();

  void addPost(String title, String content, String time, String location) {
    setState(() {
      posts.add(Post(title, content, time, location));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('게시판'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(posts[index].title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(posts[index].content),
                          SizedBox(height: 4),
                          Text('시간: ${posts[index].time}'),
                          Text('장소: ${posts[index].location}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
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
                        addPost(title, content, time, location);
                        titleController.clear();
                        contentController.clear();
                        timeController.clear();
                        locationController.clear();
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
          ],
        ),
      ),
    );
  }
}
 */
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_study0801/Mypage.dart';
import 'package:flutter_study0801/Write_Map.dart';
import 'package:flutter_study0801/Write_post.dart';
import 'package:flutter_study0801/api/api.dart';
import 'package:flutter_study0801/kakaomap/kakao_map.dart';
import 'package:flutter_study0801/model/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'post.dart'; // Post 클래스가 정의된 파일을 임포트합니다.
import 'Write_post.dart';
import 'WriteAlarm.dart';



List<Post> dummyPosts = [
    Post('출발지1', '도착지1', '시간1', false, '', '코멘트1'),
    Post('출발지2', '도착지2', '시간2', true, '왕복시간2', '코멘트2'),
    // 필요한 만큼 게시물을 추가할 수 있습니다.
    ];

class ViewPostsPage extends StatelessWidget {
  final List<Post> posts;

  ViewPostsPage({required this.posts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('게시판'),
        ),
        body: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(posts[index].departure), // 수정: departure 출력
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(posts[index].arrival), // 수정: arrival 출력
                    SizedBox(height: 4),
                    Text('시간: ${posts[index].time}'),
                    Text('왕복 여부: ${posts[index].isRoundTrip ? "왕복" : "편도"}'),
                    if (posts[index].isRoundTrip)
                      Text('왕복 시간: ${posts[index].roundTripTime}'),
                    Text('코멘트: ${posts[index].comment}'),
                  ],
                ),
              ),
            );
          },
        ),

        floatingActionButton: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment(
                Alignment.bottomRight.x, Alignment.bottomRight.y - 0.2),
              child: FloatingActionButton(
                  child: Icon(Icons.add),
                onPressed: () async {
                  Post? newPost = await Get.to(() => CreatePostPage());

                  if (newPost != null) {
                    // 작성된 글을 게시판 목록에 추가
                    posts.add(newPost);
                  }
                }

              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                  child: Icon(Icons.alarm),
                  onPressed: () async {
                    Post? newPost = await Get.to(() => AlarmPage());

                    if (newPost != null) {
                      // 작성된 글을 게시판 목록에 추가
                      posts.add(newPost);
                    }
                  }

              ),
            ),
            Align(
              alignment: Alignment(
                  Alignment.bottomRight.x, Alignment.bottomRight.y - 0.4),
              child: FloatingActionButton(
                  child: Icon(Icons.assistant_photo),
                  onPressed: () async {
                    Post? newPost = await Get.to(() => MyApp());

                    if (newPost != null) {
                      // 작성된 글을 게시판 목록에 추가
                      posts.add(newPost);
                    }
                  }

              ),
            ),
            Align(
              alignment: Alignment(
                  Alignment.bottomRight.x, Alignment.bottomRight.y - 0.6),
              child: FloatingActionButton(
                  child: Icon(Icons.loop),
                  onPressed: () async {
                    Post? newPost = await Get.to(() => MyApp1());

                    if (newPost != null) {
                      // 작성된 글을 게시판 목록에 추가
                      posts.add(newPost);
                    }
                  }

              ),
            ),
            Align(
              alignment: Alignment(
                  Alignment.bottomRight.x, Alignment.bottomRight.y - 0.8),
              child: FloatingActionButton(
                  child: Icon(Icons.person_pin),
                  onPressed: () async {
                    Post? newPost = await Get.to(() => MyPage());

                    if (newPost != null) {
                      // 작성된 글을 게시판 목록에 추가
                      posts.add(newPost);
                    }
                  }

              ),
            )

          ],
        )




      /*
          floatingActionButton: FloatingActionButton(
          onPressed: () async {
        // 글 작성 페이지로 이동하고 작성된 글을 받아옴
        Post? newPost = await Get.to(() => CreatePostPage());

        if (newPost != null) {
          // 작성된 글을 게시판 목록에 추가
          posts.add(newPost);
        }
      },
      child: Icon(Icons.add),
      ),
      */


      );
    }
  }
/*
class ViewPostsPage extends StatelessWidget {
  final List<Post> posts;

  ViewPostsPage({required this.posts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('게시판'),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(posts[index].departure), // 수정: departure 출력
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(posts[index].arrival), // 수정: arrival 출력
                  SizedBox(height: 4),
                  Text('시간: ${posts[index].time}'),
                  Text('왕복 여부: ${posts[index].isRoundTrip ? "왕복" : "편도"}'), // 수정: isRoundTrip 출력
                  if (posts[index].isRoundTrip)
                    Text('왕복 시간: ${posts[index].roundTripTime}'), // 수정: roundTripTime 출력
                  Text('코멘트: ${posts[index].comment}'), // 수정: comment 출력
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 글 작성 페이지로 이동
          Get.to(() => CreatePostPage(onPostCreated: (newPost) {
            // 새로운 게시물이 작성되었을 때 실행되는 함수
            // 이곳에서 새로운 게시물을 추가하거나 처리할 수 있습니다.
            posts.add(newPost); // 예시: 새로운 게시물을 목록에 추가
          }));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
*/



