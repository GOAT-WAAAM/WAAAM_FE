import 'package:flutter/material.dart';



class AddLater extends StatelessWidget {
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
                      '\'기타\'과목에 저장되었어요.\n폴더>과목>기타에서\n볼 수 있어요.',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            );

        }
    );
  }
}
