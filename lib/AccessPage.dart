import 'package:flutter/material.dart';
import 'MyPage.dart';


class AccessSettingsScreen extends StatefulWidget {
  @override
  _AccessSettingsScreenState createState() => _AccessSettingsScreenState();
}

class _AccessSettingsScreenState extends State<AccessSettingsScreen> {
  bool camera = false;
  bool photos = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('접근권한 설정'),
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
              title: '카메라',
              subtitle: '카메라로 바로 복습내용을 찍을 수 있어요.',
              value: camera,
              onChanged: (bool value) {
                setState(() {
                  camera = value;
                });
              },
            ),
            customSwitchListTile(
              title: '갤러리',
              subtitle: '갤러리에서 복습내용을 바로 가져올 수 있어요',
              value: photos,
              onChanged: (bool value) {
                setState(() {
                  photos = value;
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
      activeTrackColor: Colors.grey.shade300,
      inactiveThumbColor: Colors.grey,
      inactiveTrackColor: Colors.grey.shade300,
    );
  }
}
