import 'package:flutter/material.dart';
import 'NotificationPage.dart';
import 'AccessPage.dart';
import 'AccountInfoPage.dart';
import 'ProfileEditPage.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text("마이페이지"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyInfo(), //1. 나의정보
                  SizedBox( //2. 목표
                      width: 335, height: 40,
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 0.5,
                                )),
                            hintText: "나의 목표를 입력해 보세요.",
                            hintStyle: TextStyle(fontSize: 12, color: Colors.grey)),
                      )),
                  SizedBox(height: 26,),
                  AccessSetting(),
                  NotificationSetting(),
                  AcccountInfo(),
                  SizedBox(height: 121),
                  Center(child: Text("로그아웃")),//로그아웃 페이지 연결
                ]),
          )
        //1. 나의 정보
        // 2. 목표
        // 3. 설정
        // 4. 로그아웃,
      ),
      routes:{
        '/accessPage' : (context) => AccessSettingsScreen(),
        '/notificationPage' : (context) => AlarmSettingsScreen(),
        '/accountPage' : (context) => AccountInfoScreen(),
        '/profilePage' : (context) => ProfileEditPage(),
      },
    );
  }
}

class MyInfo extends StatelessWidget {
  const MyInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(5, 5, 18, 24),
              child: Image.asset('assets/image/Ellipse.png', width: 64, height: 64),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("de5642" + "님", style: TextStyle(fontSize: 16)),
              Row(
                children: [
                  Text(
                    "경영학전공" + "," + " 3학년",
                    style: TextStyle(fontSize: 12),
                  ),
                  IconButton(icon: Icon(Icons.create_outlined, size: 16, color: Color(0xFFD5D8DD),), onPressed: () {Navigator.pushNamed(context, '/profilePage');})
                ],
              )

            ] //edit.png 추가,
            ),
          ],
        ));
  }
}
class AccessSetting extends StatelessWidget {
  const AccessSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          width: 375, height: 60,
          decoration: BoxDecoration(
            border: Border(top: BorderSide(width: 1.0, color: Color(0xFFF7F7F7))),
          ),
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("접근권한 설정"),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios_rounded, size: 20, color: Color(0xFFD5D8DD),),
                onPressed: (){
                  Navigator.pushNamed(context,'/accessPage');
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
class NotificationSetting extends StatelessWidget {
  const NotificationSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      width: 375, height: 60,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(width: 1.0, color: Color(0xFFF7F7F7))),
      ),
      child:
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("알림 설정"),
          IconButton(
            icon:Icon(Icons.arrow_forward_ios_rounded, size: 20, color: Color(0xFFD5D8DD)),
            onPressed: (){
              Navigator.pushNamed(context,'/notificationPage');
            },

          )

        ],
      ),
    );
  }
}
class AcccountInfo extends StatelessWidget {
  const AcccountInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      width: 375, height: 80,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(width: 1.0, color: Color(0xFFF7F7F7)), bottom: BorderSide(width: 1.0, color: Color(0xFFF7F7F7))),
      ),
      child:
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("계정 정보"),
          IconButton(
            icon:Icon(Icons.arrow_forward_ios_rounded,size: 20, color: Color(0xFFD5D8DD)),
            onPressed: (){
              Navigator.pushNamed(context,'/accountPage');
            },

          )
        ],
      ),
    );
  }
}



