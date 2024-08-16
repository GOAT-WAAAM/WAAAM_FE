import 'package:flutter/material.dart';

import 'MyPage.dart';


class AlarmSettingsScreen extends StatefulWidget {
  @override
  _AlarmSettingsScreenState createState() => _AlarmSettingsScreenState();
}

class _AlarmSettingsScreenState extends State<AlarmSettingsScreen> {
  bool reviewNoti = false;
  bool myPost = false;
  bool myCmt = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('알림 설정'),
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            customSwitchListTile(
              title: '복습 알림',
              subtitle: '내가 설정한 요일과 시간에 복습 알림을 보내드려요.',
              value: reviewNoti,
              onChanged: (bool value) {
                setState(() {
                  reviewNoti = value;
                });
              },
            ),
            customSwitchListTile(
              title: '업데이트 알림',
              subtitle: '서비스의 업데이트 소식을 알려드려요',
              value: myPost,
              onChanged: (bool value) {
                setState(() {
                  myPost = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget customSwitchListTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.grey,
      activeTrackColor: Color(0xFF14C5C4),
      inactiveThumbColor: Colors.grey,
      inactiveTrackColor: Colors.grey.shade300,
    );
  }
}
