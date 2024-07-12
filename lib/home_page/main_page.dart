import 'package:bocket_test/home_page/mainpage_content.dart';
import 'package:bocket_test/Notify/test_page.dart';
import 'package:flutter/material.dart';
import '../components/bottom_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isNotifyExist=false;//알림 상태
  int _selectedIndex=0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(54),
        child: AppBar(
          centerTitle: false,//나중에 알림 추가되면  true로 바뀌는 함수 생성
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 19, top: 18, bottom: 16),
                child: Image.asset(
                  'assets/image/logo_mini.png',
                  width: 97.549,
                  height: 20, // 원하는 높이로 설정
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>const TestPage()),//TestPage 나중에 알림 페이지로 바꾸기
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
      ),
      body: MainPageContent(),
      bottomNavigationBar: BottomBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}