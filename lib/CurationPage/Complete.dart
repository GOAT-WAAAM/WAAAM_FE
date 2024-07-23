import 'package:bocket_test/CurationPage/RandomCuration.dart';
import 'package:bocket_test/home_page/main_page.dart';
import 'package:flutter/material.dart';

class ReviewCmpt extends StatefulWidget {
  const ReviewCmpt({super.key});

  @override
  State<ReviewCmpt> createState() => _ReviewCmptState();
}

class _ReviewCmptState extends State<ReviewCmpt> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center the children vertically
            children: [
              Image.asset("/assets/image/contrats.png"),
              Text(
                "랜덤 복습 완료 - !",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              Text(
                "오늘의 복습 분량을",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              ),
              Text(
                "모두 복습했어요!",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              ),
              SizedBox(height: 77),
              Container(
                width: 335,
                height: 56,
                padding: const EdgeInsets.only(bottom: 94.0),
                child: SizedBox(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => RandomCuration()),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xFF14C5C4)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    child: Text(
                      "한 세트 더 복습할래요",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 335,
                height: 56,
                padding: const EdgeInsets.only(bottom: 18.0),
                child: SizedBox(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MainPage()),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xFFE9F9F8)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: Color(0xFF8AE5E4)),
                        ),
                      ),
                    ),
                    child: Text(
                      "홈으로 이동",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0XFF02B6B4),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
