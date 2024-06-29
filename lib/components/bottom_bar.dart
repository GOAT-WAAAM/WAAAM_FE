import 'package:bocket_test/MyPage.dart';
import 'package:bocket_test/WriteContent/FirstPage.dart';
import 'package:bocket_test/home_page/main_page.dart';
import 'package:bocket_test/upload_page/camera_view.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {

  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  BottomBar({
    required this.selectedIndex,
    required this.onItemTapped,
  });


  void _showModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor:Colors.black.withOpacity(0),
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0), bottom: Radius.circular(20.0)), // 모달 상단에 둥근 모서리 적용
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0,

                ),
                onPressed: () {
                  Navigator.pop(context); // 모달 닫기
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>CameraView()),
                  );// 다른 작업 수행
                },
                child: Text('촬영하기',style: TextStyle(color: Colors.black,fontSize: 14,),),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0,

                ),
                onPressed: () {
                  Navigator.pop(context); // 모달 닫기
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>Placeholder()),
                  );
                },
                child: Text('앨범에서 불러오기',style: TextStyle(color: Colors.black,fontSize: 14,),),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0,

                ),
                onPressed: () {
                  Navigator.pop(context); // 모달 닫기
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>FirstPage()),
                  );
                },
                child: Text('직접 작성하기',style: TextStyle(color: Colors.black,fontSize: 14,),),
              ),
            ],
          ),
        );
      },
    );
  }

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
          onTap: (index) {
            switch (index){
              case 0:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>MainPage()),
                );
                break;
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>Placeholder()),
                );
                break;
              case 2:
                _showModal(context); // 가운데 버튼을 누를 때 모달 창 띄우기
                break;
              case 3:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>Placeholder()),
                );
                break;
              case 4:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>MyPage()),
                );
                break;

            }
          },
        ),
    );
  }
}
