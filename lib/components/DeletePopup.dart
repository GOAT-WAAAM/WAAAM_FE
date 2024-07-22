import 'package:flutter/material.dart';



class CustomDeletePopup extends StatelessWidget {
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
                      '정말 삭제하시겠습니까?',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('이 내용들은 휴지통으로 이동해요.', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),),
                    SizedBox(height: 20),
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
                            // Handle "Yes, stop reviewing" action here
                          },
                          child: Text(
                            '네, 삭제할게요',
                            style: TextStyle(
                              color: Colors.teal,
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
