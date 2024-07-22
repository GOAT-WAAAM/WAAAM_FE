import 'package:flutter/material.dart';



class DeletedPopup extends StatelessWidget {
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
                      '삭제되었습니다.\n휴지동으로 이동했어요!',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
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
