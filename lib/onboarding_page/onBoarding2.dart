import 'package:bocket_test/login/SignUpPage.dart';
import 'package:flutter/material.dart';
import 'onBoarding3.dart';

class onBoard2 extends StatefulWidget {
  const onBoard2();

  @override
  State<onBoard2> createState() => _onBoard2State();
}

class _onBoard2State extends State<onBoard2> {
  final TextEditingController _nicknameController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _nicknameController.addListener(_updateButtonState);
  }

  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  void _saveNickname() {
    final nickname = _nicknameController.text;
    // Save nickname logic
    print('닉네임: $nickname');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => onBoard3(nickname: nickname)),
    );
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _nicknameController.text.isNotEmpty;
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
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
          ),
          title: Text(
            '내 정보 입력',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
        ),
        body: Container(
          margin: EdgeInsets.fromLTRB(20, 27, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "와암의 가입을 축하드려요!",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              Text(
                "어떻게 불러드릴까요?",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 200),
              TextField(
                controller: _nicknameController,
                decoration: InputDecoration(
                  hintText: '닉네임을 작성해 주세요',
                  hintStyle:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 299),
              Center(
                child: GestureDetector(
                  onTap: _isButtonEnabled ? _saveNickname : null,
                  child: Container(
                    alignment: Alignment.center,
                    width: 290,
                    height: 60,
                    decoration: BoxDecoration(
                      color: _isButtonEnabled
                          ? Color(0xFF02B6B4)
                          : Color(0xFFBABFCA),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
