import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddFolderPopup extends StatefulWidget {
  final Function(String) onAddClass;

  const AddFolderPopup({Key? key, required this.onAddClass}) : super(key: key);

  @override
  _AddFolderPopupState createState() => _AddFolderPopupState();
}

class _AddFolderPopupState extends State<AddFolderPopup> {
  String folderName = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('폴더 추가하기'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('폴더명', style: TextStyle(fontSize: 18)),
          TextField(
            decoration: InputDecoration(
              hintText: '폴더명 입력',
            ),
            onChanged: (value) {
              setState(() {
                folderName = value;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('취소'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onAddClass(folderName);
            Navigator.of(context).pop();
          },
          child: Text('추가완료'),
        ),
      ],
    );
  }
}
