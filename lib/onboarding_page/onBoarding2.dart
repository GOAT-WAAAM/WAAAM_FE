import 'package:bocket_test/login/SignUpPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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

  Future<void> _saveNickname() async {
    final nickname = _nicknameController.text;

    try {
      // Retrieve FCM token
      String? token = await FirebaseMessaging.instance.getToken();

      if (token == null) {
        throw Exception('Failed to retrieve FCM token');
      }

      // Navigate to onBoard3 with nickname and FCM token
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => onBoard3(nickname: nickname, fcmToken: token),
        ),
      );
    } catch (e) {
      // Handle the error, e.g., show a snackbar or dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _nicknameController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get keyboard height
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final isKeyboardVisible = keyboardHeight > 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()),
            );
          },
        ),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 55),
            child: Text(
              '내 정보 입력',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 27, 20, 20),
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
            Expanded(
              child: Column(
                children: [
                  TextField(
                    controller: _nicknameController,
                    decoration: InputDecoration(
                      hintText: '닉네임을 작성해 주세요',
                      hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFD5D8DD), width: 1.0),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFD5D8DD), width: 2.0),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  // This Spacer ensures that the '다음' button is pushed to the bottom when the keyboard is not visible
                  Spacer(),
                  if (!isKeyboardVisible) ...[
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
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
