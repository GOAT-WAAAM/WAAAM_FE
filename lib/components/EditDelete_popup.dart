import 'package:flutter/material.dart';

class EditdeletePopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) {
          return
            Theme(
              data: Theme.of(context).copyWith(dialogBackgroundColor: Colors.white),
              child: Container(
                width: 204,
                  height: 107,
                child: AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(21),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                          onPressed: (){},
                          child:
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("수정하기", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),),
                                  Image.asset("assets/image/Edit.png", width: 24, height: 24,),
                                ],
                              ),
                      ),
                      TextButton(
                        onPressed: (){},
                        child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("삭제하기", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black)),
                            Image.asset("assets/image/trash.png", width: 24, height: 24),
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
