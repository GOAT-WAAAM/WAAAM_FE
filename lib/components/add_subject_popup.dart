import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddSubjectPopup extends StatefulWidget {
  final Function(String) onAddClass;

  const AddSubjectPopup({Key? key, required this.onAddClass}) : super(key: key);

  @override
  _AddSubjectPopupState createState() => _AddSubjectPopupState();
}

class _AddSubjectPopupState extends State<AddSubjectPopup> {
  String subjectName = '';
  int selectedIconIndex = -1;
  int selectedColorIndex = -1;

  final List<Widget> icons = [
    SizedBox(
      width: 36,
      height: 36,
      child: SvgPicture.asset('assets/svg/pencil.svg'),
    ),
    SizedBox(
      width: 36,
      height: 36,
      child: SvgPicture.asset('assets/svg/bluebook.svg'),
    ),
    SizedBox(
      width: 36,
      height: 36,
      child: SvgPicture.asset('assets/svg/lightbulb.svg'),
    ),
    SizedBox(
      width: 36,
      height: 36,
      child: SvgPicture.asset('assets/svg/yellowbook.svg'),
    ),
  ];

  final List<Color> colors = [
    Color(0xFFFF5D47),
    Color(0xFFFF9950),
    Color(0xFFFFDC61),
    Color(0xFFFFA0E4),
    Color(0xFF14CD5E),
    Color(0xFF14C5C4),
    Color(0xFF09B5FF),
    Color(0xFF5061FF),
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('과목 추가하기'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('과목명', style: TextStyle(fontSize: 18)),
          TextField(
            decoration: InputDecoration(
              hintText: '과목명 입력',
            ),
            onChanged: (value) {
              setState(() {
                subjectName = value;
              });
            },
          ),
          SizedBox(height: 20),
          Text('아이콘', style: TextStyle(fontSize: 18)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(icons.length, (index) {
              return IconButton(
                icon: Container(
                  padding: EdgeInsets.all(1.0), // Adjust padding if needed
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: icons[index],
                ),
                onPressed: () {
                  setState(() {
                    selectedIconIndex = index;
                  });
                },
              );
            }),
          ),
          SizedBox(height: 20),
          Text('색상 선택', style: TextStyle(fontSize: 18)),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(colors.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedColorIndex = index;
                  });
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: colors[index],
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: selectedColorIndex == index ? Colors.black : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
              );
            }),
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
            widget.onAddClass(subjectName);
            Navigator.of(context).pop();
          },
          child: Text('추가완료'),
        ),
      ],
    );
  }
}
