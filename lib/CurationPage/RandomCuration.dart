import 'package:flutter/material.dart';
import '../Models/Curation.dart';
import '../Models/data.dart';
import '../home_page/main_page.dart';
import 'package:bocket_test/CurationPage/Review.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: RandomCuration(),
    );
  }
}

class RandomCuration extends StatefulWidget {
  const RandomCuration({super.key});

  @override
  State<RandomCuration> createState() => _RandomCurationState();
}

class _RandomCurationState extends State<RandomCuration> {
  bool isStarred = false;

  void handleStar() {
    setState(() {
      isStarred = !isStarred;
    });
  }

  void _showTextPopup(BuildContext context, String text) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    String bottomText = "Pilot study (test)\n"
        "– 본 연구의 소규모 테스트 실행\n"
        "– 연구 계획이 실행 가능한지 확인 ...";

    String popupText = "Pilot study(test)\n"
        "– 본 연구의 소규모 테스트 실행\n"
        "– 연구 계획이 실행 가능한지 확인\n\n"
        "– Pilot studies check that:\n"
        "  * 절차대로 수행 할 수 있는지 확인\n"
        "  * interview scripts, questionnaires, experiments, etc. work appropriately\n\n"
        "– 본 연구를 수행하기 전에 여러 가지 문제를 해결하는 것이 바람직함\n"
        "Pilot study(test)\n"
        "– 본 연구의 소규모 테스트 실행\n"
        "– 연구 계획이 실행 가능함치 확인\n\n"
        "–Pilot study(test)\n"
        "– 본 연구의 소규모 테스트 실행...";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MainPage()),
            );
          },
          icon: Image.asset('assets/image/X.png'),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: handleStar,
              icon: isStarred
                  ? Image.asset('assets/image/favorite.png')
                  : Image.asset('assets/image/non_favorite.png'),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 48),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        width: 333,
                        height: 444,
                        child: CurationScreen(stories: stories),
                      ),
                      GestureDetector(
                        onTap: () => _showTextPopup(context, popupText),
                        child: Container(
                          color: Colors.transparent,
                          padding: EdgeInsets.all(16),
                          child: Text(
                            bottomText,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 18.0),
            child: SizedBox(
              width: 335,
              height: 51,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Review()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFF14C5C4)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                child: Text(
                  "복습하러 가기",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
