import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(54),
        child: AppBar(
          centerTitle: false,//나중에 알림 추가되면  true로 바뀌는 함수 생성
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 18, bottom: 16, right: 30),
                  child:Text('복습정보 입력', style: TextStyle(fontSize: 18,fontFamily:'Pretendard',),),
                ),
              ],
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            Row(
            children: [
              Text('사진 제목',style: TextStyle(fontSize: 14,fontFamily: 'Pretendard'),),
              Text('*',style: TextStyle(fontSize: 14,color: Colors.red,fontFamily: 'Pretendard'),),

            ],
            )
          ],
        )
      ),
    );
  }
}
