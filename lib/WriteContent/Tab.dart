// TabBarCmp.dart
import 'package:bocket_test/WriteContent/ManualReviewInput.dart';
import 'package:flutter/material.dart';
import 'ManualReviewInput.dart';

class TabBarCmp extends StatefulWidget {
  @override
  _TabBarCmpState createState() => _TabBarCmpState();
}

class _TabBarCmpState extends State<TabBarCmp> with SingleTickerProviderStateMixin {
  bool isSwitchOn = true;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('복습 반복',
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600)),
                  Switch(
                    activeTrackColor: Color(0XFF14C5C4),
                    activeColor: Colors.white,
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Color(0XFFBABFCA),
                    value: isSwitchOn,
                    onChanged: (value) {
                      setState(() {
                        isSwitchOn = value;
                      });
                    },
                  ),
                ],
              ),
              Visibility(
                visible: isSwitchOn,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: TabBar(
                        controller: _tabController,
                        indicator: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        tabs: [
                          Tab(text: '자동 복습'),
                          Tab(text: '수동 입력'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 300,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 50),
                            child:
                            Text('자동으로 복습할 수 있도록\n잊혀질 때 쯤 알림을 보내드릴게요!',
                                textAlign:TextAlign.center,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),

                          ),
                          Center(child: ManualInput()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  }
}
