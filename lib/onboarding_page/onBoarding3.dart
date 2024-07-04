import 'package:flutter/material.dart';
import 'onBoarding2.dart';
import 'onBoardingComplete.dart';

class onBoard3 extends StatefulWidget {
  final String? nickname;

  const onBoard3({this.nickname});

  @override
  State<onBoard3> createState() => _onBoard3State();
}

class _onBoard3State extends State<onBoard3> {
  List<bool> selectedGoals = [false, false, false, false, false];
  bool get isAnyGoalSelected => selectedGoals.contains(true);

  void toggleSelection(int index) {
    setState(() {
      selectedGoals[index] = !selectedGoals[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => onBoard2()),
              );
            },
          ),
          title: Text(
            '내 목표 입력',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
        ),
        body: Container(
          margin: EdgeInsets.fromLTRB(20, 27, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "복습으로 달성할",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              Text(
                "${widget.nickname ?? ''}님의 목표를 알려주세요!",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 12),
              TextButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(Icons.create_outlined, size: 18, color: Color(0xFF747B85)),
                    SizedBox(width: 4),
                    Text(
                      "직접 입력할게요",
                      style: TextStyle(
                        color: Color(0xFF747B85),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFF747B85),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Wrap(
                spacing: 20.0,
                runSpacing: 20.0,
                children: [
                  Goal(
                    text: "매일매일 공부",
                    selected: selectedGoals[0],
                    onTap: () => toggleSelection(0),
                  ),
                  Goal(
                    text: "A+을 향해서",
                    selected: selectedGoals[1],
                    onTap: () => toggleSelection(1),
                  ),
                  Goal(
                    text: "자격증 합격",
                    selected: selectedGoals[2],
                    onTap: () => toggleSelection(2),
                  ),
                  Goal(
                    text: "시험공부는 꼼꼼히",
                    selected: selectedGoals[3],
                    onTap: () => toggleSelection(3),
                  ),
                  Goal(
                    text: "일상 속 복습 습관 만들기",
                    selected: selectedGoals[4],
                    onTap: () => toggleSelection(4),
                  ),
                ],
              ),
              Expanded(child: Container()), // Fills up the remaining space
              Center(
                child: GestureDetector(
                  onTap: isAnyGoalSelected
                      ? () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => onBoardCmpt(nickname: widget.nickname)),
                    );
                  }
                      : null,
                  child: Container(
                    alignment: Alignment.center,
                    width: 290,
                    height: 60,
                    decoration: BoxDecoration(
                      color: isAnyGoalSelected ? Color(0xFF02B6B4) : Color(0xFFBABFCA),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '다음',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20), // Adds spacing below the button
            ],
          ),
        ),
      ),
    );
  }
}

class Goal extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onTap;

  const Goal({
    required this.text,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: IntrinsicWidth(
        child: Container(
          height: 40,
          padding: EdgeInsets.fromLTRB(14, 8, 14, 8),
          decoration: BoxDecoration(
            color: selected ? Color(0xFFE9F9F8) : Color(0xFFEEEEEF),
            borderRadius: BorderRadius.circular(18),
            border: selected ? Border.all(
              color: Color(0xFF8AE5E4), width: 1) : null
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: selected ? Color(0xFF02B6B4) : Color(0xFF747B85),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
