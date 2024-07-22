import 'package:bocket_test/components/reviewPeriod.dart';
import 'package:bocket_test/components/selectDays.dart';
import 'package:bocket_test/components/selectTime.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ReviewContent extends StatefulWidget {
  @override
  State<ReviewContent> createState() => _ReviewContentState();
}

class _ReviewContentState extends State<ReviewContent> {
  bool _reviewAgain = true;
  bool _shareContent = true;
  List<bool> _selectedReviewMode = [true, false]; // 초기값 설정
  String? selectedSubject;
  String? selectedFolder;
  List<dynamic> subjects = [];
  List<dynamic> folders = [];
  List<dynamic> selectDays = [];
  String? title;
  String? content;
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    super.initState();
    fetchSubjects();
  }

  Future<void> fetchSubjects() async {
    final response = await http.get(Uri.parse('http://43.202.27.170/goat/directory?directoryId=0'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        subjects = data['results']['directoryResponseList'];
      });
    }
  }

  Future<void> fetchFolders(int directoryId) async {
    final response = await http.get(Uri.parse('http://43.202.27.170/goat/directory?directoryId=$directoryId'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        folders = data['results']['directoryResponseList'];
      });
    }
  }

  bool get _isFormValid {
    return title != null &&
        content != null &&
        selectedSubject != null &&
        selectedFolder != null &&
        selectDays.isNotEmpty &&
        startDate != null &&
        endDate != null &&
        startDate!.isBefore(endDate!);
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
                child: Text('복습정보 입력',
                    style: TextStyle(fontSize: 18, fontFamily: 'Pretendard')),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Text('사진 제목',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600)),
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
                    child: TextField(
                      onChanged: (text) {
                        setState(() {
                          title = text;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        labelText: '제목 입력',
                        labelStyle: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Pretendard',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    children: [
                      Text('내용',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    height: 64,
                    child: TextField(
                      onChanged: (text) {
                        setState(() {
                          content = text;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        labelText: '내용 입력',
                        labelStyle: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Pretendard',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    children: [
                      Text('과목',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600)),
                      Text('*',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFFFF5050),
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600)),
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
                            fontSize: 14,
                            fontFamily: 'Pretendard',
                          ),
                        ),
                        value: selectedSubject,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedSubject = newValue;
                            selectedFolder = null;
                            folders = [];
                            fetchFolders(subjects.firstWhere((subject) =>
                            subject['directoryName'] == newValue)['directoryId']);
                          });
                        },
                        items: subjects.map<DropdownMenuItem<String>>((dynamic value) {
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
                            fontSize: 14,
                            fontFamily: 'Pretendard',
                          ),
                        ),
                        value: selectedFolder,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedFolder = newValue;
                          });
                        },
                        items: folders.map<DropdownMenuItem<String>>((dynamic value) {
                          return DropdownMenuItem<String>(
                            value: value['directoryName'],
                            child: Text(value['directoryName']),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
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
                                  for (int i = 0; i < _selectedReviewMode.length; i++) {
                                    _selectedReviewMode[i] = i == index;
                                  }
                                });
                              },
                              fillColor: Colors.white,
                              selectedColor: Colors.black,
                              borderRadius: BorderRadius.circular(22.0),
                              children: [
                                Container(
                                  width: (MediaQuery.of(context).size.width - 44) / 2,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  decoration: BoxDecoration(
                                    color: _selectedReviewMode[0] ? Colors.white : Color(0xFFD5D8DD),
                                    borderRadius: const BorderRadius.horizontal(left: Radius.circular(10)),
                                  ),
                                  child: Text(
                                    '자동 복습',
                                    style: TextStyle(
                                      fontFamily: 'Pretendard',
                                      fontSize: 14,
                                      color: _selectedReviewMode[0] ? Colors.black : Color(0xFFBABFCA),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: (MediaQuery.of(context).size.width - 44) / 2,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  decoration: BoxDecoration(
                                    color: _selectedReviewMode[1] ? Colors.white : Color(0xFFD5D8DD),
                                    borderRadius: const BorderRadius.horizontal(right: Radius.circular(10)),
                                  ),
                                  child: Text(
                                    '수동 입력',
                                    style: TextStyle(
                                      fontFamily: 'Pretendard',
                                      fontSize: 14,
                                      color: _selectedReviewMode[1] ? Colors.black : Color(0xFFBABFCA),
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
                                SizedBox(height: 30),
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
                                SizedBox(height: 42),
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
                                SizedBox(height: 16),
                                SelectDays(),
                                SizedBox(height: 32),
                                const Row(
                                  children: [
                                    Text('복습 시간',
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
                                SizedBox(height: 16),
                                SelectTimes(),
                                SizedBox(height: 32),
                                const Row(
                                  children: [
                                    Text('복습 종료일',
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
                                SizedBox(height: 16),
                                ReviewPeriod(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '게시판 공유',
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
                        value: _shareContent,
                        onChanged: (value) {
                          setState(() {
                            _shareContent = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 60,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isFormValid ? () {
                // 버튼 클릭 시 처리할 로직을 여기에 추가하세요.
              } : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isFormValid ? Color(0xFF14C5C4) :  Color(0xFFD9D9D9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                '내용 저장',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Pretendard',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
