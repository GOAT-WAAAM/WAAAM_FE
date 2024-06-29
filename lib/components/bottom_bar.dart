import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {

  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  BottomBar({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          //home navigation bar
          BottomNavigationBarItem(
            icon: Image.asset('assets/image/home_default.png', width: 48,height: 48,),
            activeIcon: Image.asset('assets/image/home_active.png',width: 48,height: 48,),
          ),
          //게시판 버튼
          BottomNavigationBarItem(
            icon: Image.asset('assets/image/community_default.png', width: 48,height: 48,),
            activeIcon: Image.asset('assets/image/community_active.png',width: 48,height: 48,),
          ),
          //+버튼
          BottomNavigationBarItem(
            icon: Image.asset('assets/image/modalbutton.png')
          ),
          //folder
          BottomNavigationBarItem(
            icon: Image.asset('assets/image/folder_default.png', width: 48,height: 48,),
            activeIcon: Image.asset('assets/image/folder_active.png',width: 48,height: 48,),
          ),
          //mypage button
          BottomNavigationBarItem(
            icon: Image.asset('assets/image/mypage_default.png', width: 48,height: 48,),
            activeIcon: Image.asset('assets/image/mypage_active.png',width: 48,height: 48,),
          ),
        ],
        currentIndex: selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }
}
