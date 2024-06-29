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
    return SizedBox(
        height: 84,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Image.asset('assets/image/home_default.png', width: 48,height: 48,),
              activeIcon: Image.asset('assets/image/home_active.png',width: 48,height: 48,),
              label: '', // 항목의 레이블 추가
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/image/review_default.png', width: 48,height: 48,),
              activeIcon: Image.asset('assets/image/review_active.png',width: 48,height: 48,),
              label: '', // 항목의 레이블 추가
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/image/plus.png', width: 48,height: 48,),
              label: '', // 레이블이 필요 없는 항목은 빈 문자열로 지정
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/image/folder_default.png', width: 48,height: 48,),
              activeIcon: Image.asset('assets/image/folder_active.png',width: 48,height: 48,),
              label: '', // 항목의 레이블 추가
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/image/mypage_default.png', width: 48,height: 48,),
              activeIcon: Image.asset('assets/image/mypage_active.png',width: 48,height: 48,),
              label: '', // 항목의 레이블 추가
            ),
          ],
          currentIndex: selectedIndex,
          onTap: onItemTapped,
        ),
    );
  }
}
