import 'package:flutter/material.dart';

import '../login/SignUpPage.dart';



class LogoutPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) {
          return
            Theme(
              data: Theme.of(context).copyWith(dialogBackgroundColor: Colors.white),
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(21),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '로그아웃 하시겠습니까?',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            '아니요',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => MyHomePage()),
                            );
                            // Handle "Yes, stop reviewing" action here
                          },
                          child: Text(
                            '로그아웃',
                            style: TextStyle(
                              color: Color(0xFF02B6B4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );

        }
    );
  }
}
