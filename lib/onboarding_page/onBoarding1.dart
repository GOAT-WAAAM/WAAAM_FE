import 'package:bocket_test/onboarding_page/OnBoardContents.dart';
import 'package:flutter/material.dart';

import 'onBoarding2.dart';

class onBoard1 extends StatefulWidget {
  const onBoard1({super.key});

  @override
  State<onBoard1> createState() => _onBoard1State();
}

class _onBoard1State extends State<onBoard1> {
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
            SizedBox(height: 90),
            onBoardCnt(),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: SizedBox(
                    width: 291,
                    height: 50,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => onBoard2()),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                          )
                        )
                      ),
                      child: Text(
                        "다음",
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
            ),
          ],
        ),
      ),
    );
  }
}
