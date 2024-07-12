import 'package:flutter/material.dart';
import 'AccessPage.dart';
import 'AccountInfoPage.dart';
import 'NotificationPage.dart';
import '../Notify/test_page.dart';
import 'ProfileEditPage.dart';
import '../components/bottom_bar.dart';
// import 'LoginPage.dart'; // Uncomment this when the page is implemented

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  bool isNotifyExist = false; // 알림 상태
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      routes: {
        '/accessPage': (context) => AccessSettingsScreen(),
        '/notificationPage': (context) => AlarmSettingsScreen(),
        '/accountPage': (context) => AccountInfoScreen(),
        '/profilePage': (context) => ProfileEditPage(),
        // '/logoutPage' : (context) => LoginPage(),  // Uncomment this when the page is implemented
      },
      home: Scaffold(
        appBar: AppBar(
          centerTitle: false, // 나중에 알림 추가되면 true로 바뀌는 함수 생성
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 19, top: 18, bottom: 16),
                child: Text("마이페이지"),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TestPage()), // TestPage 나중에 알림 페이지로 바꾸기
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 20, top: 15, bottom: 15),
                child: Image.asset(
                  isNotifyExist
                      ? 'assets/image/bell_color.png'
                      : 'assets/image/bell_default.png',
                  width: 24,
                  height: 24,
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyInfo(), // 1. 나의정보
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 26),
                    AccessSetting(),
                    NotificationSetting(),
                    AcccountInfo(),
                    SizedBox(height: 121),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/logoutPage');
                        },
                        child: Text("로그아웃"),
                      ),
                    ), // 로그아웃 페이지 연결
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }
}

class MyInfo extends StatefulWidget {
  const MyInfo({super.key});

  @override
  State<MyInfo> createState() => _MyInfoState();
}

class _MyInfoState extends State<MyInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(5, 5, 18, 24),
            child: Image.asset('assets/image/Ellipse.png', width: 64, height: 64),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("de5642" + "님", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              IconButton(
                icon: Icon(Icons.create_outlined, size: 16, color: Color(0xFFD5D8DD)),
                onPressed: () {
                  Navigator.pushNamed(context, '/profilePage');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}



class AccessSetting extends StatefulWidget {
  const AccessSetting({super.key});

  @override
  State<AccessSetting> createState() => _AccessSettingState();
}

class _AccessSettingState extends State<AccessSetting> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          width: 375,
          height: 60,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(width: 1.0, color: Color(0xFFF7F7F7)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("접근권한 설정"),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20,
                  color: Color(0xFFD5D8DD),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/accessPage');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class NotificationSetting extends StatefulWidget {
  const NotificationSetting({super.key});

  @override
  State<NotificationSetting> createState() => _NotificationSettingState();
}

class _NotificationSettingState extends State<NotificationSetting> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      width: 375,
      height: 60,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0, color: Color(0xFFF7F7F7)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("알림 설정"),
          IconButton(
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
              color: Color(0xFFD5D8DD),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/notificationPage');
            },
          ),
        ],
      ),
    );
  }
}

class AcccountInfo extends StatefulWidget {
  const AcccountInfo({super.key});

  @override
  State<AcccountInfo> createState() => _AcccountInfoState();
}

class _AcccountInfoState extends State<AcccountInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      width: 375,
      height: 80,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0, color: Color(0xFFF7F7F7)),
          bottom: BorderSide(width: 1.0, color: Color(0xFFF7F7F7)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("계정 정보"),
          IconButton(
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
              color: Color(0xFFD5D8DD),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/accountPage');
            },
          ),
        ],
      ),
    );
  }
}
