import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../components/LogoutPopup.dart';
import 'AccessPage.dart';
import 'AccountInfoPage.dart';
import 'NotificationPage.dart';
import '../Notify/notify_page.dart';
import 'ProfileEditPage.dart';
import '../components/bottom_bar.dart';
import 'package:bocket_test/Provider/user_provider.dart';


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
                      builder: (context) => const NotifyPage()), // TestPage 나중에 알림 페이지로 바꾸기
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MyInfo(), // 1. 나의정보
              SizedBox(height: 20),
              GoalSection(), // 2. 나의 목표
              SizedBox(height: 10),
              WeeklyReviewSection(), // 3. 이번주 복습
              SizedBox(height: 26),
              AccessSetting(),
              NotificationSetting(),
              AcccountInfo(),
              SizedBox(height: 50),
              Center(
                child: TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return LogoutPopup();
                      },
                    );
                  },
                  child: Text("로그아웃", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF888888), decoration: TextDecoration.underline, decorationColor: Color(0xFF888888))),
                ),
              ), // 로그아웃 페이지 연결
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
    final userProvider=Provider.of<UserProvider>(context);
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(30, 5, 18, 24),
            child: Image.asset('assets/image/defaultProfile.png', width: 64, height: 64),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("${userProvider.nickname}님", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
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

class GoalSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider=Provider.of<UserProvider>(context);
    return Center(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 81,
              height: 29,
              decoration: BoxDecoration(
                color: Color(0xFFE9F9F8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Image.asset("assets/image/fire.png", width: 17, height: 25,),
                  Text("나의 목표", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
                ],
              ),
            ),
            SizedBox(width: 16),
            Container(
              width: 247,
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              decoration: BoxDecoration(
                color: Color(0xFFE9F9F8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(child: Text("\"${userProvider.goal}\"", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600), textAlign: TextAlign.center,)),
            ),
          ],
        ),
      ),
    );
  }
}


class WeeklyReviewSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 81, height: 29,
            decoration: BoxDecoration(
              color: Color(0xFFF7F7F7),
              borderRadius: BorderRadius.circular(8),
            ),
            child:
                Center(child: Text("이번주 복습", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)))
          ),
          SizedBox(width: 16),
          Container(
            width: 247,
            height: 29,
            decoration: BoxDecoration(
              color: Color(0xFFF7F7F7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(child: Text("7일간 총 14번 복습했어요!", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
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
