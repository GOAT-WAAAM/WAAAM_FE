import 'package:flutter/material.dart';

import '../components/LogoutPopup.dart';
import '../components/SignoutPopup.dart';
import 'MyPage.dart';


class AccountInfoScreen extends StatefulWidget {
  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('계정 정보'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyPage()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('이메일', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFD5D8DD)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: <Widget>[
                  Image.asset('assets/image/Naver.png', width: 24, height: 24,),
                  SizedBox(width: 8),
                  Text('de5642@naver.com', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            Center(child: Column(
              children: [
                SizedBox(height: 32),
                SizedBox(
                  width: 335, height: 50,
                  child: OutlinedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return LogoutPopup();
                        },
                      );
                    },
                    child: Text('로그아웃', style: TextStyle(color: Colors.grey)),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Color(0xFFD5D8DD)),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: 335, height: 50,
                  child: OutlinedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SignoutPopup();
                        },
                      );
                    },
                    child: Text('회원탈퇴', style: TextStyle(color: Colors.grey)),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Color(0xFFD5D8DD)),
                    ),
                  ),
                ),],
            ),),
          ],
        ),
      ),
    );
  }
}
