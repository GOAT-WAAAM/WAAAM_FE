import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List<String> dropdownList = ['1', '2', '3'];

  String selectedDropdown = '1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(54),
        child: AppBar(
          centerTitle: false,//나중에 알림 추가되면  true로 바뀌는 함수 생성
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 18, bottom: 16, right: 30),
                  child:Text('복습정보 입력', style: TextStyle(fontSize: 18,fontFamily:'Pretendard',),),
                ),
              ],
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
              children: [
                Text('사진 제목',style: TextStyle(fontSize: 14,fontFamily: 'Pretendard'),),
                Text('*',style: TextStyle(fontSize: 14,color: Colors.red,fontFamily: 'Pretendard'),),
              ],
              ),
              SizedBox(height: 16,),
              Container(
                child: Flexible(
                  child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                        labelText: '제목 입력',
                        labelStyle: TextStyle(
                          fontSize: 14, // 원하는 글꼴 크기 설정
                          fontFamily: 'Pretendard', // 원하는 글꼴 설정
                        ),
                  )
                              ,
                )),
                height: 42,
              ),
              Row(
                children: [
                  Text('내용',style: TextStyle(fontSize: 14,fontFamily: 'Pretendard'),),
                ],
              ),
              SizedBox(height: 16,),
              Container(
                child: Flexible(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                        labelText: '내용 입력',
                        labelStyle: TextStyle(
                          fontSize: 14, // 원하는 글꼴 크기 설정
                          fontFamily: 'Pretendard', // 원하는 글꼴 설정
                        ),
                      )
                      ,
                    )),
                height: 64,
              ),
              Row(
                children: [
                  Text('과목',style: TextStyle(fontSize: 14,fontFamily: 'Pretendard'),),
                  Text('*',style: TextStyle(fontSize: 14,color: Colors.red,fontFamily: 'Pretendard'),),
                ],
              ),
              SizedBox(height: 16,),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
                  children: [
                    new DropdownButtonHideUnderline(
                        child: Container(
                            width: 355,
                            height: 50,
                            padding: EdgeInsets.all(8.0),
                            // 내부 여백 추가
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            child: SchoolDropDown()))
                  ],
                ),
              ),
            ]
          ),
        )
      ),
    );
  }
}

class SchoolDropDown extends StatefulWidget {
  @override
  _SchoolDropdownState createState() => _SchoolDropdownState();
}

class _SchoolDropdownState extends State<SchoolDropDown> {
  final List<String> _schools = ["중학교", "고등학교", "대학교", "기타"];
  String? _selectedSchool;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      style: TextStyle(
        fontSize: 13,
        color: Colors.black,
      ),
      hint: Text("과목 선택"),
      value: _selectedSchool,
      onChanged: (String? newVal) {
        setState(() {
          _selectedSchool = newVal;
        });
      },
      items: _schools.map((String school) {
        return DropdownMenuItem<String>(
          value: school,
          child: Text(school),
        );
      }).toList(),
    );
  }
}
