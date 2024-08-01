import 'package:flutter/material.dart';

class WriteCmp extends StatefulWidget {
  const WriteCmp({super.key});

  @override
  State<WriteCmp> createState() => _WriteCmpState();
}

class _WriteCmpState extends State<WriteCmp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("저장 완료!", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),),
            Image.asset('assets/image/fighting.png', width: 222, height: 222,),
            Text("시작이 반!\n벌써 절반이나 복습했어요!", textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
          ],
        ),
      ),
    );
  }
}
