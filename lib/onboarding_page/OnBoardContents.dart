import 'package:flutter/material.dart';
import 'dart:async';

class onBoardCnt extends StatefulWidget {
  @override
  State<onBoardCnt> createState() => _onBoardCntState();
}

class _onBoardCntState extends State<onBoardCnt> {
  final List<Widget> _imageWidgets = [
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("에빙하우스의 망각곡선", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24,color: Colors.white),),
        SizedBox(height: 13),
        Text("학습한 지 1일만 지나도", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white),),
        Text("70% 이상 망각돼요", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white),),
        SizedBox(height: 42),
        Image.asset('assets/image/onBoard1.png', width: 289, height: 289),
      ],
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("1초만에 내용입력", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24,color: Colors.white),),
        SizedBox(height: 13),
        Text("공부한 내용을 옮겨적을", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white)),
        Text("필요없이 사진 찍어 저장해요", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white)),
        SizedBox(height: 42),
        Image.asset('assets/image/onBoard2.png', width: 323, height: 323,),
      ],
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("떠먹여주는 복습", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24,color: Colors.white),),
        SizedBox(height: 13),
        Text("뭘 복습할 지 조차 모르겠다면", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white)),
        Text("터치 한 번으로 바로 복습!", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white)),
        SizedBox(height: 42),
        Image.asset('assets/image/reminderBanner.png', width: 323, height: 323,),
      ],
    ),
  ];

  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startImageChangeTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startImageChangeTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _imageWidgets.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: _imageWidgets[_currentIndex],
      ),
    );
  }
}
