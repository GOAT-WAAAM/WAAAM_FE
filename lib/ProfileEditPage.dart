import 'package:flutter/material.dart';
import 'MyPage.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({Key?key}) : super(key: key);

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 31),
            Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: AssetImage('assets/image/Ellipse.png'),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.edit, size: 16),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ProfileField(label: '이름', value: 'de5642'),
                  SizedBox(height: 20),
                  ProfileField(label: '전공 / 분야', value: '경영학과'),
                  SizedBox(height: 20),
                  ProfileField(label: '학년', value: '3학년'),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  const TopBar({Key? key}) : super(key: key); // Corrected constructor

  @override
  State<TopBar> createState() => _TopBarState();

  @override
  Size get preferredSize => Size.fromHeight(54.0); // Implemented preferredSize getter
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF7F7F7))),
      ),
      child: AppBar(
        title: Text("프로필 수정"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyPage()),
            );
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
    );
  }
}


class ProfileField extends StatefulWidget {
  final String label;
  final String value;

  const ProfileField({super.key, required this.label, required this.value});

  @override
  State<ProfileField> createState() => _ProfileFieldState();
}

class _ProfileFieldState extends State<ProfileField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 4),
        Container(
          width: 335,
          height: 50,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[400]!),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            widget.value,
            style: TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}

