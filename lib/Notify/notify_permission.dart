import 'package:bocket_test/Provider/token_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotifyPermission extends StatefulWidget {
  const NotifyPermission({super.key});

  @override
  State<NotifyPermission> createState() => _NotifyPermissionState();
}

class _NotifyPermissionState extends State<NotifyPermission> {
  bool reviewNotificationEnabled = false;
  bool otherNotificationEnabled1 = false;
  bool otherNotificationEnabled2 = false;

  final String apiUrl = 'http://43.202.27.170/goat/mypage/notification/setting'; // API URL

  @override
  void initState() {
    super.initState();
    _loadNotificationSettings();
  }

  Future<void> _loadNotificationSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      reviewNotificationEnabled = prefs.getBool('reviewNotification') ?? false;
      otherNotificationEnabled1 = prefs.getBool('otherNotification1') ?? false;
      otherNotificationEnabled2 = prefs.getBool('otherNotification2') ?? false;
    });
  }

  Future<void> _saveNotificationSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('reviewNotification', reviewNotificationEnabled);
    prefs.setBool('otherNotification1', otherNotificationEnabled1);
    prefs.setBool('otherNotification2', otherNotificationEnabled2);

    // Send PUT request
    await _updateNotificationSettings();
  }

  Future<void> _requestNotificationPermission() async {
    PermissionStatus status = await Permission.notification.request();
    if (status.isGranted) {
      print("Notification permission granted");
    } else {
      print("Notification permission denied");
      setState(() {
        reviewNotificationEnabled = false;
      });
    }
  }

  Future<void> _updateNotificationSettings() async {
    final tokenProvider = Provider.of<TokenProvider>(context, listen: false);
    final accessToken = tokenProvider.accessToken;

    final response = await http.put(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({
        'isReviewNoti': reviewNotificationEnabled,
      }),
    );

    if (response.statusCode == 200) {
      print('Notification settings updated successfully');
    } else {
      print('Failed to update notification settings');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(54),
        child: AppBar(
          centerTitle: false,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 18, bottom: 16, right: 30),
                child: Text('알림 설정',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Color(0xFFBABFCA),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20, top: 24),
                child: _buildCustomSwitchListTile(
                  title: '복습 알림',
                  subtitle: '내가 설정한 요일과 시간에 복습 알림을 보내드려요.',
                  value: reviewNotificationEnabled,
                  onChanged: (bool value) {
                    setState(() {
                      reviewNotificationEnabled = value;
                      if (value) {
                        _requestNotificationPermission().then((_) {
                          _saveNotificationSettings();
                        });
                      } else {
                        _saveNotificationSettings();
                      }
                    });
                  },
                ),
              ),
              _buildDivider(),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20, top: 24),
                child: _buildCustomSwitchListTile(
                  title: '내 게시글',
                  subtitle: '작성한 게시글의 댓글, 스크랩 알림',
                  value: otherNotificationEnabled1,
                  onChanged: (bool value) {
                    setState(() {
                      otherNotificationEnabled1 = value;
                      _saveNotificationSettings();
                    });
                  },
                ),
              ),
              _buildDivider(),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20, top: 24),
                child: _buildCustomSwitchListTile(
                  title: '내 댓글',
                  subtitle: '작성한 댓글의 대댓글 알림',
                  value: otherNotificationEnabled2,
                  onChanged: (bool value) {
                    setState(() {
                      otherNotificationEnabled2 = value;
                      _saveNotificationSettings();
                    });
                  },
                ),
              ),
              _buildDivider(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomSwitchListTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                  color: Colors.black)),
          Text(subtitle,
              style: TextStyle(
                  color: Color(0xFFBABFCA),
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Pretendard')),
        ],
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.white, // 스위치 활성화 색상
        activeTrackColor: Color(0xFF14C5C4), // 스위치 활성화 트랙 색상
        inactiveThumbColor: Colors.white, // 스위치 비활성화 색상
        inactiveTrackColor: Color(0xFFA2A9B5),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1.6,
      color: Color(0xFFF7F7F7),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
    );
  }
}
