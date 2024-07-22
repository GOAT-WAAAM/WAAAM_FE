import 'package:bocket_test/WriteContent/ReviewContent.dart';
import 'package:bocket_test/home_page/main_page.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class WriteOrnot extends StatelessWidget {
  final File image;

  const WriteOrnot({required this.image, super.key});

  void _navigateToMainPage(BuildContext context) {
    Navigator.pop(context); // Close the current screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainPage(),
        settings: RouteSettings(arguments: 'showPopup'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0x32000000), // rgba(0, 0, 0, 0.02)
                  offset: Offset(0, 4), // 0px 4px
                  blurRadius: 8.2, // 8.2px
                ),
              ],
            ),
            child: AppBar(
              backgroundColor: Colors.white,
              elevation: 0, // Optional: Remove default shadow
              title: Center(
                child: Text(
                  '복습정보 입력',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Pretendard',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '복습에 대한 정보를 지금 입력하실 건가요?',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '복습 정보는 나중에도 입력할 수 있어요.',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 42),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReviewContent(),
                          ),
                        );
                      },
                      child: Text(
                        '지금 복습정보 입력하기',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide(
                          color:Color(0xFFD5D8DD),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        minimumSize: Size(double.infinity, 54), // Full width with a fixed height of 54
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: ElevatedButton(
                      onPressed: () => _navigateToMainPage(context),
                      child: Text(
                        '나중에 입력하기',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF14C5C4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        minimumSize: Size(double.infinity, 54), // Full width with a fixed height of 54
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
