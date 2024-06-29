import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(54),
        child: AppBar(
          centerTitle: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 19, top: 18, bottom: 16),
                child: Image.asset(
                  'assets/image/logo_mini.png',
                  width: 97.549,
                  height: 20, // 원하는 높이로 설정
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      body: Text('page routing test 성공'),
    );
  }
}
