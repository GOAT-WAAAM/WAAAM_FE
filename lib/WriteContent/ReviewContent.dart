// ReviewContent.dart
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'PreWrite.dart';
import 'Tab.dart';
class ReviewContent extends StatefulWidget {
  @override
  State<ReviewContent> createState() => _ReviewContentState();
}

class _ReviewContentState extends State<ReviewContent> {
  bool _reviewAgain = true;
  bool _shareContent = true;
  List<bool> _selectedReviewMode = [true, false];
  String? selectedSubject;
  String? selectedFolder;
  List<dynamic> subjects = [];
  List<dynamic> folders = [];
  List<dynamic> selectDays = [];
  String? title;
  String? content;
  DateTime? startDate;
  DateTime? endDate;

  Future<void> fetchSubjects() async {
    try {
      final response = await http.get(Uri.parse('http://43.202.27.170/goat/directory?directoryId=0'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          subjects = data['results']['directoryResponseList'];
        });
      } else {
        print('Failed to load subjects');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchFolders(int directoryId) async {
    try {
      final response = await http.get(Uri.parse('http://43.202.27.170/goat/directory?directoryId=$directoryId'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          folders = data['results']['directoryResponseList'];
        });
      } else {
        print('Failed to load folders');
      }
    } catch (e) {
      print('Error: $e');
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => PreWrite()), // Adjust as needed
          );
        }, icon: Image.asset('assets/image/left_chev.png')),
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
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                    width: 335,
                    height: 50,
                    child: TextField(
                      onChanged: (text) {
                        setState(() {
                          title = text;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                        hintText: '제목 입력',
                        hintStyle: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Pretendard',
                            color: Color(0xFFD5D8DD)
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
                    width: 335,
                    height: 100,
                    child: TextField(
                      onChanged: (text) {
                        setState(() {
                          content = text;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        hintText: '내용 입력',
                        hintStyle: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Pretendard',
                            color: Color(0xFFD5D8DD)
                        ),
                      ),
                      maxLines: null,
                    ),
                  ),
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
                            color: Color(0xFFD5D8DD),
                          ),
                        ),
                        value: selectedSubject,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedSubject = newValue;
                            selectedFolder = null;
                            folders = [];
                            if (newValue != null) {
                              final subject = subjects.firstWhere((subject) =>
                              subject['directoryName'] == newValue, orElse: () => {});
                              if (subject.isNotEmpty) {
                                fetchFolders(subject['directoryId']);
                              }
                            }
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
                              color: Color(0xFFD5D8DD)
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
                  const SizedBox(height: 16),
                  Divider(height: 30, color: Color(0xFFF7F7F7), thickness: 5,),
                  const SizedBox(height: 16),
                  TabBarCmp(), // Include TabBarCmp here
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 52,
            margin: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: _isFormValid ? () {
                // Submit form or perform action
              } : null,
              child: Text('내용 저장',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600)),
              style: ElevatedButton.styleFrom(
                backgroundColor: _isFormValid ? Colors.blue : Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
