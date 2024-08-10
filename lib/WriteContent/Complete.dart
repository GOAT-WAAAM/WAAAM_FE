import 'package:bocket_test/home_page/main_page.dart';
import 'package:flutter/material.dart';

class WriteCmp extends StatefulWidget {
  const WriteCmp({super.key});

  @override
  State<WriteCmp> createState() => _WriteCmpState();
}

class _WriteCmpState extends State<WriteCmp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "저장 완료!",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
            ),
            Image.asset(
              'assets/image/fighting.png',
              width: 222,
              height: 222,
            ),
            const Text(
              "시작이 반!\n벌써 절반이나 복습했어요!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            Container(
              margin: EdgeInsets.only(top: 170),
              width: 290,
              height: 60,
              child: TextButton(

                onPressed: () {Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()), // Adjust as needed
                );},
                child: const Text(
                  "홈으로 이동",
                  style: TextStyle(color: Color(0xFF02B6B4), fontSize: 20, fontWeight: FontWeight.w500 ),
                ),
                style: ButtonStyle(

                  backgroundColor: MaterialStateProperty.all(const Color(0xFFE9F9F8)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
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
