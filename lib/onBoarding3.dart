import 'package:flutter/material.dart';
import 'home_page/main_page.dart';
import 'onBoarding2.dart';

class onBoard3 extends StatefulWidget {
  final String? nickname; // Define nickname as a parameter
  const onBoard3({this.nickname});

  @override
  State<onBoard3> createState() => _onBoard3State();
}

class _onBoard3State extends State<onBoard3> {
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
                "${widget.nickname}님의 목표를 알려주세요!",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 16,),
              TextButton(onPressed: (){},
                child: Row(
                  children: [
                    Icon(Icons.create_outlined, size: 10,color: Color(0xFF747B85),),
                    Text("직접 입력할게요",
                      style: TextStyle(
                        color:Color(0xFF747B85),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                        decorationColor:Color(0xFF747B85),
                      ),
                    ),],
                )
              ),
              Center(
                child: GestureDetector(
                  onTap: (){Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage()),
                  );},
                  child: Container(
                    alignment: Alignment.center,
                    width: 290,
                    height: 60,
                    decoration: BoxDecoration(
                      color:
                      // _isButtonEnabled?
                        Color(0xFF02B6B4),
                          // : Color(0xFFBABFCA),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '다음',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
