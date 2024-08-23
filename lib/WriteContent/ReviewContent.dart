import 'package:bocket_test/WriteContent/Complete.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../components/add_folder_popup.dart';
import '../components/add_subject_popup.dart';
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
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  String selectedPeriod = '';
  int selectedHour = 0;
  int selectedMinute = 0;

  void _handlePeriodChanged(String period) {
    setState(() {
      selectedPeriod = period;
    });
  }

  void _handleHourChanged(int hour) {
    setState(() {
      selectedHour = hour;
    });
  }

  void _handleMinuteChanged(int minute) {
    setState(() {
      selectedMinute = minute;
    });
  }

  void _handleStartDateChanged(DateTime? startDate) {
    setState(() {
      selectedStartDate = startDate;
    });
  }

  void _handleEndDateChanged(DateTime? endDate) {
    setState(() {
      selectedEndDate = endDate;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchSubjects();
  }

  Future<void> fetchSubjects() async {
    try {
      final response = await http.get(Uri.parse('http://43.202.27.170/goat/directory?directoryId=0'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          subjects = data['results']['directoryResponseList'];
          // Ensure '새 과목 추가' is not duplicated
          if (subjects.every((subject) => subject['directoryName'] != '새 과목 추가')) {
            subjects.add({'directoryId': -1, 'directoryName': '새 과목 추가'});
          }
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
          // Ensure '새 폴더 추가' is not duplicated
          if (folders.every((folder) => folder['directoryName'] != '새 폴더 추가')) {
            folders.add({'directoryId': -1, 'directoryName': '새 폴더 추가'});
          }
        });
      } else {
        print('Failed to load folders');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  bool get _isFormValid {
    // Store the result of the validation in a variable
    bool isValid = title != null &&
        selectedSubject != null &&
        selectedFolder != null;
        // selectDays.isNotEmpty &&
        // selectedStartDate != null &&
        // selectedEndDate != null &&
        // selectedHour != null &&
        // selectedMinute != null &&
        // selectedPeriod != null &&
        // selectedStartDate!.isBefore(selectedEndDate!);

    // Print information if the form is valid

      print('Form is valid with the following information:');
      print('Title: $title');
      print('Content: $content');
      print('Selected Subject: $selectedSubject');
      print('Selected Folder: $selectedFolder');
      print('Selected Days: $selectDays');
      print('Start Date: $selectedStartDate');
      print('End Date: $selectedEndDate');
      print('Selected Period: $selectedPeriod');
      print('Selected Hour: $selectedHour');
      print('Selected Minute: $selectedMinute');

    // Return the validation result
    return isValid;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => PreWrite()), // Adjust as needed
            );
          },
          icon: Image.asset('assets/image/left_chev.png'),
        ),
        centerTitle: false,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 18, bottom: 16, right: 30),
              child: Text(
                '복습정보 입력',
                style: TextStyle(fontSize: 18, fontFamily: 'Pretendard'),
              ),
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
                      Text(
                        '사진 제목',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '*',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFFFF5050),
                          fontFamily: 'Pretendard',
                        ),
                      ),
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
                          color: Color(0xFFD5D8DD),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    children: [
                      Text(
                        '내용',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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
                          color: Color(0xFFD5D8DD),
                        ),
                      ),
                      maxLines: null,
                    ),
                  ),
                  const Row(
                    children: [
                      Text(
                        '과목',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '*',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFFFF5050),
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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
                        items: subjects.map<DropdownMenuItem<String>>((dynamic value) {
                          return DropdownMenuItem<String>(
                            value: value['directoryName'],
                            child: Text(value['directoryName']),
                          );
                        }).toList()
                          ..add(
                            const DropdownMenuItem<String>(
                              value: '새 과목 추가',
                              child: Text('새 과목 추가'),
                            ),
                          ),
                        onChanged: (String? newValue) {
                          if (newValue == '새 과목 추가') {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AddSubjectPopup(
                                  onAddClass: (String newSubject) {
                                    setState(() {
                                      subjects.add({'directoryId': -1, 'directoryName': newSubject});
                                      selectedSubject = newSubject;
                                    });
                                  },
                                );
                              },
                            );
                          } else {
                            setState(() {
                              selectedSubject = newValue;
                              fetchFolders(subjects.firstWhere((element) => element['directoryName'] == newValue)['directoryId']);
                            });
                          }
                        },
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
                            color: Color(0xFFD5D8DD),
                          ),
                        ),
                        value: selectedFolder,
                        items: folders.map<DropdownMenuItem<String>>((dynamic value) {
                          return DropdownMenuItem<String>(
                            value: value['directoryName'],
                            child: Text(value['directoryName']),
                          );
                        }).toList()
                          ..add(
                            const DropdownMenuItem<String>(
                              value: '새 폴더 추가',
                              child: Text('새 폴더 추가'),
                            ),
                          ),
                        onChanged: (String? newValue) {
                          if (newValue == '새 폴더 추가') {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AddFolderPopup(
                                  onAddClass: (String newFolder) {
                                    setState(() {
                                      folders.add({'directoryId': -1, 'directoryName': newFolder});
                                      selectedFolder = newFolder;
                                    });
                                  },
                                );
                              },
                            );
                          } else {
                            setState(() {
                              selectedFolder = newValue;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Divider(height: 30, color: Color(0xFFF7F7F7), thickness: 5,),
                  const SizedBox(height: 16),
                  TabBarCmp(
                    onPeriodChanged: _handlePeriodChanged,
                    onHourChanged: _handleHourChanged,
                    onMinuteChanged: _handleMinuteChanged,
                    onStartDateChanged: _handleStartDateChanged,
                    onEndDateChanged: _handleEndDateChanged,
                  ),
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => WriteCmp()),
                );
              } : null,
              child: Text(
                '내용 저장',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: _isFormValid ? Color(0xff14C5C4) : Colors.grey,
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
