import 'package:bocket_test/Notify/notify_permission.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:bocket_test/Provider/token_provider.dart';

class NotifyPage extends StatefulWidget {
  const NotifyPage({super.key});

  @override
  State<NotifyPage> createState() => _NotifyPageState();
}

class _NotifyPageState extends State<NotifyPage> {
  List<NotificationItem> notifications = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchNotifications();
  }

  Future<void> _fetchNotifications() async {
    const String url = 'http://43.202.27.170/goat/notification';
    final tokenProvider = Provider.of<TokenProvider>(context, listen: false);
    final accessToken = tokenProvider.accessToken;

    if (accessToken == null) {
      print('Access token is missing');
      setState(() {
        isLoading = false;
      });
      return;
    }

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> notificationsData = data['results']['notifications'];

        setState(() {
          notifications = notificationsData.map((item) => NotificationItem.fromJson(item)).toList();
          isLoading = false;
        });
      } else {
        print('Failed to load notifications: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
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
                child: Text('알림',
                    style: TextStyle(fontSize: 18, fontFamily: 'Pretendard', fontWeight: FontWeight.w600, color: Colors.black)),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.keyboard_arrow_left, color: Color(0xFFBABFCA)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.settings, color: Colors.black), // 설정 아이콘 추가
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotifyPermission()), // 설정 페이지로 이동
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator()) // Show loading indicator while fetching data
                : notifications.isEmpty
                ? Center(child: Text('알림이 없습니다.'))
                : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.reviewBody,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 8),
                      Text(
                        notification.whenItPushed,
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          _buildDivider(), // Add divider
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Center(
              child: Text(
                '최근 30일 이내의 알림을 확인할 수 있습니다.',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
          ),
        ],
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

class NotificationItem {
  final int notificationId;
  final int reviewId;
  final String reviewBody;
  final String whenItPushed;
  final bool isRead;

  NotificationItem({
    required this.notificationId,
    required this.reviewId,
    required this.reviewBody,
    required this.whenItPushed,
    required this.isRead,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      notificationId: json['notificationId'],
      reviewId: json['reviewId'],
      reviewBody: json['reviewBody'],
      whenItPushed: json['whenItPushed'],
      isRead: json['isRead'],
    );
  }
}
