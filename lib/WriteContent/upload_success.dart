import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: UploadSuccess(),
    );
  }
}

class UploadSuccess extends StatelessWidget {
  const UploadSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
            padding: const EdgeInsets.all(55),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '저장 완료!',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontFamily: 'Pretendard',
                    fontSize: 22,
                  ),
                ),
                Image.asset('assets/image/fighting.png',width: 283.31,height: 257.31,),
                Text('시작이 반! \n 벌써 절반이나 복습했어요!',style: TextStyle(color: Colors.black,fontFamily: 'Pretendard',fontSize: 16,fontWeight: FontWeight.w400),textAlign: TextAlign.center, )
              ],
            ),
          ),
        ),
      );
  }
}
