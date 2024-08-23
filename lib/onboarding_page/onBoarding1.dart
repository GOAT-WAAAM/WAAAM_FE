import 'package:flutter/material.dart';
import 'onBoarding2.dart';

class onBoard1 extends StatefulWidget {
  const onBoard1({super.key});

  @override
  State<onBoard1> createState() => _onBoard1State();
}

class _onBoard1State extends State<onBoard1> {
  int _currentIndex = 0;

  void handleNext() {
    setState(() {
      if (_currentIndex < _imageWidgets.length - 1) {
        _currentIndex += 1;
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => onBoard2()),
        );
      }
    });
  }


  final List<Widget> _imageWidgets = [
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("에빙하우스의 망각곡선", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24, color: Colors.white)),
        SizedBox(height: 13),
        Text("학습한 지 1일만 지나도", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white)),
        Text("70% 이상 망각돼요", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white)),
        SizedBox(height: 42),
        Image.asset('assets/image/onBoard1.png', width: 289, height: 289),
      ],
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("1초만에 내용입력", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24, color: Colors.white)),
        SizedBox(height: 13),
        Text("공부한 내용을 옮겨적을", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white)),
        Text("필요없이 사진 찍어 저장해요", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white)),
        ClipRect(
          child: Align(
            alignment: Alignment.topCenter,
            heightFactor: 1.0,
            child: Transform.translate(
              offset: Offset(0, -10),
              child: Image.asset(
                'assets/image/onBoard2.png',
                width: 323,
                height: 319,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("떠먹여주는 복습", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24, color: Colors.white)),
        SizedBox(height: 13),
        Text("뭘 복습할 지 조차 모르겠다면", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white)),
        Text("터치 한 번으로 바로 복습!", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white)),
        SizedBox(height: 20),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset("assets/image/reminderBanner.png", width: 335, height: 148,),
        ),

      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Color(0xFF02B6B4)),
      home: Scaffold(
        body: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                child: Image.asset('assets/image/indicator.png'),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                  child: _imageWidgets[_currentIndex],
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: SizedBox(
                  width: 291,
                  height: 50,
                  child: TextButton(
                    onPressed: handleNext,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    child: Text(
                      _currentIndex == 2 ? "완료" : "다음",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF02B6B4),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
