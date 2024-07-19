import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

enum Days{ Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday }

class SelectDays extends StatefulWidget {
  const SelectDays({super.key});

  @override
  State<SelectDays> createState() => _SelectDaysState();
}

class _SelectDaysState extends State<SelectDays> {

  Set<Days> filters=<Days>{};

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme=Theme.of(context).textTheme;

    return Center(
      child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: <Widget>[
         Wrap(
           spacing: 5.0,
           children: Days.values.map((Days day){
             return FilterChip(
               label: Text(day.name),
               selected:filters.contains(day),
               onSelected: (bool selected){
                 setState(() {
                   if(selected){
                     filters.add(day);
                   }else{
                     filters.remove(day);
                   }
                 });
               },
             );
           }).toList(),
         ),
       ],
      )
    );

  }
  String _dayToString(Days day) {
    switch (day) {
      case Days.Monday:
        return '월';
      case Days.Tuesday:
        return '화';
      case Days.Wednesday:
        return '수';
      case Days.Thursday:
        return '목';
      case Days.Friday:
        return '금';
      case Days.Saturday:
        return '토';
      case Days.Sunday:
        return '일';
      default:
        return '';
    }
  }
}


class FirstPage extends StatefulWidget {
  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  bool _reviewAgain = true;
  List<bool> _selectedReviewMode = [true, false]; // 초기값 설정
  String? selectedSubject;
  String? selectedFolder;
  List<dynamic> subjects = [];
  List<dynamic> folders = [];

  @override
  void initState() {
    super.initState();
    fetchSubjects();
  }

  Future<void> fetchSubjects() async {
    final response = await http
        .get(Uri.parse('http://43.202.27.170/goat/directory?directoryId=0'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        subjects = data['results']['directoryResponseList'];
      });
    }
  }

  Future<void> fetchFolders(int directoryId) async {
    final response = await http.get(Uri.parse(
        'http://43.202.27.170/goat/directory?directoryId=$directoryId'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        folders = data['results']['directoryResponseList'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(54),
        child: AppBar(
          centerTitle: false, // 나중에 알림 추가되면 true로 바뀌는 함수 생성
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 18, bottom: 16, right: 30),
                child: Text('복습정보 입력',
                    style: TextStyle(fontSize: 18, fontFamily: 'Pretendard')),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Row(
                children: [
                  Text('사진 제목',
                      style: TextStyle(fontSize: 14, fontFamily: 'Pretendard',fontWeight: FontWeight.w600)),
                  Text('*',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFFFF5050),
                          fontFamily: 'Pretendard')),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 42,
                child: const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    labelText: '제목 입력',
                    labelStyle: TextStyle(
                      fontSize: 14, // 원하는 글꼴 크기 설정
                      fontFamily: 'Pretendard', // 원하는 글꼴 설정
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Row(
                children: [
                  Text('내용',
                      style: TextStyle(fontSize: 14, fontFamily: 'Pretendard',fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 64,
                child: const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    labelText: '내용 입력',
                    labelStyle: TextStyle(
                      fontSize: 14, // 원하는 글꼴 크기 설정
                      fontFamily: 'Pretendard', // 원하는 글꼴 설정
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Row(
                children: [
                  Text('과목',
                      style: TextStyle(fontSize: 14, fontFamily: 'Pretendard',fontWeight: FontWeight.w600)),
                  Text('*',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFFFF5050),
                          fontFamily: 'Pretendard',fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 16),
              DropdownButtonHideUnderline(
                child: Container(
                  height: 42,
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  child: DropdownButton<String>(
                    hint: const Text(
                      '과목 선택',
                      style: TextStyle(
                        fontSize: 14, // 원하는 글꼴 크기 설정
                        fontFamily: 'Pretendard', // 원하는 글꼴 설정
                      ),
                    ),
                    value: selectedSubject,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedSubject = newValue;
                        selectedFolder = null;
                        folders = [];
                        fetchFolders(subjects.firstWhere((subject) =>
                            subject['directoryName'] ==
                            newValue)['directoryId']);
                      });
                    },
                    items:
                        subjects.map<DropdownMenuItem<String>>((dynamic value) {
                      return DropdownMenuItem<String>(
                        value: value['directoryName'],
                        child: Text(value['directoryName']),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonHideUnderline(
                child: Container(
                  width: double.infinity,
                  height: 42,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  child: DropdownButton<String>(
                    hint: const Text(
                      '폴더 선택',
                      style: TextStyle(
                        fontSize: 14, // 원하는 글꼴 크기 설정
                        fontFamily: 'Pretendard', // 원하는 글꼴 설정
                      ),
                    ),
                    value: selectedFolder,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedFolder = newValue;
                      });
                    },
                    items:
                        folders.map<DropdownMenuItem<String>>((dynamic value) {
                      return DropdownMenuItem<String>(
                        value: value['directoryName'],
                        child: Text(value['directoryName']),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '복습 반복',
                    style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  Switch(
                    activeTrackColor: const Color(0xFF14C5C4),
                    activeColor: Colors.white,
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: const Color(0xFFBABFCA),
                    value: _reviewAgain,
                    onChanged: (value) {
                      setState(() {
                        _reviewAgain = value;
                      });
                    },
                  ),
                ],
              ),
              Visibility(
                visible: _reviewAgain,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 35,
                        child: ToggleButtons(
                          isSelected: _selectedReviewMode,
                          onPressed: (int index) {
                            setState(() {
                              for (int i = 0;
                                  i < _selectedReviewMode.length;
                                  i++) {
                                _selectedReviewMode[i] = i == index;
                              }
                            });
                          },
                          fillColor: Colors.white, //토글의 선택된 버튼 배경색
                          selectedColor: Colors.black, //선택된 글자 검정
                          borderRadius: BorderRadius.circular(22.0),
                          children: [
                            Container(
                              width: (MediaQuery.of(context).size.width - 44) / 2,
                              alignment: Alignment.center,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              decoration: BoxDecoration(
                                color: _selectedReviewMode[0]
                                    ? Colors.white
                                    : Color(0xFFD5D8DD),
                                borderRadius: const BorderRadius.horizontal(
                                    left: Radius.circular(10)),
                              ),
                              child: Text(
                                '자동 복습',
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontSize: 14,
                                  color: _selectedReviewMode[0]
                                      ? Colors.black
                                      : Color(0xFFBABFCA),
                                ),
                              ),
                            ),
                            Container(
                              width: (MediaQuery.of(context).size.width - 44) / 2,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              decoration: BoxDecoration(
                                color: _selectedReviewMode[1]
                                    ? Colors.white
                                    : Color(0xFFD5D8DD),
                                borderRadius: const BorderRadius.horizontal(
                                    right: Radius.circular(10)),
                              ),
                              child: Text(
                                '수동 입력',
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontSize: 14,
                                  color: _selectedReviewMode[1]
                                      ? Colors.black
                                      : Color(0xFFBABFCA),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: _selectedReviewMode[0],
                        child: const Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              '자동으로 복습할 수 있도록',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              '잊혀질 때 쯤 알림을 보내드릴게요!',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            // 여기에 자동 복습에 관련된 내용을 추가하세요.
                          ],
                        ),
                      ),
                      Visibility(
                        visible: _selectedReviewMode[1],
                        child: const Column(
                          children: [
                            SizedBox(
                              height: 42,
                            ),
                            const Row(
                              children: [
                                Text('복습 요일',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w600)),
                                Text('*',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFFFF5050),
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ],

                        ),
                      ),
                      Container(
                        child: SelectDays(),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
