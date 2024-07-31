import 'package:bocket_test/WriteContent/ReviewContent.dart';
import 'package:bocket_test/home_page/main_page.dart';
import 'package:flutter/material.dart';

import '../components/AddLater_popup.dart';

class PreWrite extends StatefulWidget {
  const PreWrite({super.key});

  @override
  State<PreWrite> createState() => _PreWriteState();
}

class _PreWriteState extends State<PreWrite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(54),
        child: AppBar(
          leading: IconButton(onPressed:() {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MainPage()),
            );
          },icon: Image.asset('assets/image/left_chev.png')),
          // centerTitle: false,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 18, bottom: 16, right: 30),
                child: Text('복습정보 입력',
                    style: TextStyle(fontSize: 18, fontFamily: 'Pretendard')),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 207),
        child: Center(
          child: Column(
            children: [
              Text("복습에 대한 정보를 지금 입력하실 건가요?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
              SizedBox(height: 10,),
              Text("복습 정보는 나중에도 입력할 수 있어요.", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),),
              SizedBox(height: 43,),
              TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.fromLTRB(56, 17, 56, 17),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Color(0xFFD5D8DD)), // Border color
                      ),
                    ),
                  ),

                  onPressed: (){
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ReviewContent()),

                );}, child: Text("지금 복습정보 입력하기", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),)),
              SizedBox(height: 15,),
              TextButton(style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFF14C5C4)),
                padding: MaterialStateProperty.all(
                  EdgeInsets.fromLTRB(56, 17, 56, 17),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Border color
                  ),
                ),
              )
                  ,onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                    return AddLater();
                    },
                    );
                   Future.delayed(Duration(seconds: 2), () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage()),
                    );
                  });
               }, child: Text("나중에 입력하기", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),)),
            ],
          ),
        ),
      ),
    );
  }
}
