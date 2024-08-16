import 'package:bocket_test/CurationPage/Complete.dart';
import 'package:bocket_test/CurationPage/contextPage.dart';
import 'package:flutter/material.dart';

import '../Models/data.dart';
import '../Models/Curation.dart';
import '../components/EditDelete_popup.dart';
import '../components/QuitPopup.dart';
import 'RandomCuration.dart';

class Review extends StatefulWidget {
  const Review({super.key});

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(onPressed: (){Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => RandomCuration()),
          );},icon: Image.asset("assets/image/left_chev.png"),),
          title: Text("1. IMC 정의"),
          actions: [
            IconButton(onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return EditdeletePopup();
            },
          );
          }, icon: Image.asset("assets/image/more.png"),)
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 309,
                  height: 442,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: CurationScreen(stories: stories),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child:
                    TextButton(
                      onPressed: (){
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => contextPage(context: popupText)),
                        );
                      },
                      child:
                      Text(
                        popupText,
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    )
                  ),
                ),
                Container(
                  width: 126,
                  height: 60,
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: SizedBox(
                    child: TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomQuitPopup();
                          },
                        );
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                      child: Text(
                        "복습 그만하기",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
