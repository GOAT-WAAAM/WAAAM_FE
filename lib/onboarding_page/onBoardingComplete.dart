import 'package:flutter/material.dart';

import '../home_page/main_page.dart';

class onBoardCmpt extends StatefulWidget {
  final String? nickname;
  const onBoardCmpt({super.key, required this.nickname});

  @override
  State<onBoardCmpt> createState() => _onBoardCmptState();
}

class _onBoardCmptState extends State<onBoardCmpt> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "반가워요 ${widget.nickname}님!",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10), // Adding a bit of space between the two texts
              Text(
                "이제 와암과 함께\n어디서나 쉽게 복습할 수 있어요!",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                textAlign: TextAlign.center,
              ),
          SizedBox(height: 398),
          Center(
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>const MainPage()),//TestPage 나중에 알림 페이지로 바꾸기
                );
              },
              child: Container(
                alignment: Alignment.center,
                width: 290,
                height: 60,
                decoration: BoxDecoration(
                  color: Color(0xFFE9F9F8),
                    borderRadius: BorderRadius.circular(12)
                ),
                child: Text(
                  '홈으로 이동',
                  style: TextStyle(
                    color: Color(0xFF02B6B4),
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ),
          ),
            ],
          ),
        ),
      )
    );
  }
}
