import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.chevron_left),
          title: Text('내 정보 입력'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            child: Container(
              height: 1.0,
              decoration: BoxDecoration(
                color: Colors.grey,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.9),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 3),
                  )
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 274,
                height: 58,
                margin: EdgeInsets.fromLTRB(0, 27, 81, 38),
                child: Text(
                  "간단한 정보를 알려주시면\n더 많은 내용을 복습할 수 있어요",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
                        children: [
                          Text("학교", style: TextStyle(fontSize: 14.0)),
                          Padding(
                            padding: EdgeInsets.only(bottom: 12.0),
                          ),
                          new DropdownButtonHideUnderline(
                              child: Container(
                                  width: 335,
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
                    SizedBox(height: 20),
                    Container(
                      width: 335, height: 90,
                      child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text("전공 / 분야", style: TextStyle(fontSize: 14.0)),
                          Padding(
                            padding: EdgeInsets.only(bottom: 12.0),
                          ),
                          TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0,
                                    )
                                ),
                                hintText: "전공, 분야를 입력해주세요 ex)경영학과",
                                hintStyle: TextStyle(
                                    fontSize: 13, color: Colors.grey)
                            ),),
                        ],
                      ),),
                    SizedBox(height: 20),
                    Container(
                      child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("학년", style: TextStyle(fontSize: 14.0)),
                          Padding(
                            padding: EdgeInsets.only(bottom: 12.0),
                          ),
                          new DropdownButtonHideUnderline(
                              child: Container(
                                  width: 335,
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
                                  child: YearDropDown()))
                        ],),)


                  ],
                ),
              ),
              SizedBox(height: 40),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("(선택) 알림 수신 동의", style: TextStyle(fontSize: 14.0)),
                    Text("자동 복습 알림을 받을게요.", style: TextStyle(fontSize: 14.0)),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0), // 주변 패딩 추가
            child: SizedBox(
              width: 291,
              height: 50,
              child: TextButton(
                onPressed: () {
                  // 버튼 클릭 시 수행할 동작
                },
                child: Text(
                  "회원가입 완료",
                  style: TextStyle(
                    color: Colors.white, // 텍스트 색상 설정
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xFFCDD3DD), // 버튼 배경색 설정
                  padding: EdgeInsets.symmetric(vertical: 10.0), // 버튼 내부 패딩 설정
                ),
              ),
            ),
          ),
        ),
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
      hint: Text("학교를 선택해 주세요"),
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

class YearDropDown extends StatefulWidget {
  @override
  _YearDropdownState createState() => _YearDropdownState();
}

class _YearDropdownState extends State<YearDropDown> {
  final List<String> _years = ["1학년", "2학년", "3학년", "4학년"];
  String? _selectedYear;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      style: TextStyle(
        fontSize: 13,
      ),
      hint: Text("학년을 선택해 주세요"),
      value: _selectedYear,
      onChanged: (String? newVal) {
        setState(() {
          _selectedYear = newVal;
        });
      },
      items: _years.map((String year) {
        return DropdownMenuItem<String>(
          value: year,
          child: Text(year),
        );
      }).toList(),
    );
  }
}
