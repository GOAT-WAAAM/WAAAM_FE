import 'package:flutter/material.dart';

import '../CurationPage/Complete.dart';



class CustomQuitPopup extends StatelessWidget {
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
              content: Container(
                padding: EdgeInsets.only(top: 40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '복습을 정말 그만두시겠습니까?',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('이 내용들은 복습 창고로 이동해요.', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
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
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => ReviewCmpt()),
                              );
                            },
                            child: Text(
                              '네, 그만둘래요',
                              style: TextStyle(
                                color: Color(0xFF02B6B4),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );

      }
    );
  }
}
