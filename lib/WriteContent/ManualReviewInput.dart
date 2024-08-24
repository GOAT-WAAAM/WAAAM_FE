import 'package:bocket_test/Provider/manualInput_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ManualInput extends StatefulWidget {
  final Function(String) onPeriodChanged;
  final Function(int) onHourChanged;
  final Function(int) onMinuteChanged;
  final Function(DateTime?) onStartDateChanged;
  final Function(DateTime?) onEndDateChanged;

  ManualInput({
    required this.onPeriodChanged,
    required this.onHourChanged,
    required this.onMinuteChanged,
    required this.onStartDateChanged,
    required this.onEndDateChanged,
  });

  @override
  State<ManualInput> createState() => _ManualInputState();
}

class _ManualInputState extends State<ManualInput> {
  List<String> weekdays = ["월", "화", "수", "목", "금", "토", "일"];

  @override
  Widget build(BuildContext context) {
    final manualInputProvider = Provider.of<ManualinputProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. 복습 요일
              Container(
                margin: EdgeInsets.only(bottom: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1) 제목
                    Row(
                      children: [
                        Text(
                          "복습 요일",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '*',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFFFF5050),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    // 2) 동그라미
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(weekdays.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (manualInputProvider.weekdays.contains(weekdays[index])) {
                                manualInputProvider.setWeekdays(
                                    manualInputProvider.weekdays
                                        .where((day) => day != weekdays[index])
                                        .toList());
                              } else {
                                manualInputProvider.setWeekdays([
                                  ...manualInputProvider.weekdays,
                                  weekdays[index]
                                ]);
                              }
                            });
                          },
                          child: Container(
                            child: CircleAvatar(
                              backgroundColor: manualInputProvider.weekdays
                                  .contains(weekdays[index])
                                  ? Color(0xFF02B6B4)
                                  : Colors.white,
                              child: Text(
                                weekdays[index],
                                style: TextStyle(
                                  color: manualInputProvider.weekdays
                                      .contains(weekdays[index])
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                              Border.all(color: Color(0xffD5D8DD), width: 1.0),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // 2. 복습시간
              Container(
                margin: EdgeInsets.only(bottom: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "복습 시간",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '*',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFFFF5050),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Color(0xFFD5D8DD),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8)))),
                          onPressed: () => _selectPeriod(context),
                          child: Text(
                            manualInputProvider.period.isEmpty
                                ? "오전/오후"
                                : manualInputProvider.period,
                            style: TextStyle(color: Color(0xFFD5D8DD)),
                          ),
                        ),
                        TextButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Color(0xFFD5D8DD),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8)))),
                          onPressed: () => _selectHour(context),
                          child: Text(
                            manualInputProvider.hour == 0
                                ? "00"
                                : manualInputProvider.hour
                                .toString()
                                .padLeft(2, '0'),
                            style: TextStyle(color: Color(0xFFD5D8DD)),
                          ),
                        ),
                        Text(':'),
                        TextButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Color(0xFFD5D8DD),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8)))),
                          onPressed: () => _selectMinute(context),
                          child: Text(
                            manualInputProvider.minute == 0
                                ? "00"
                                : manualInputProvider.minute
                                .toString()
                                .padLeft(2, '0'),
                            style: TextStyle(color: Color(0xFFD5D8DD)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Show selected time
              if (manualInputProvider.period.isNotEmpty &&
                  manualInputProvider.hour != 0 &&
                  manualInputProvider.minute != 0)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(manualInputProvider.period),
                    Text(manualInputProvider.hour.toString().padLeft(2, '0')),
                    Text(':'),
                    Text(manualInputProvider.minute.toString().padLeft(2, '0')),
                  ],
                ),
              SizedBox(height: 16.0),
              // 3. 복습 시작일, 종료일
              Container(
                margin: EdgeInsets.only(bottom: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "복습 시작일",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '*',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFFFF5050),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Color(0xFFD5D8DD),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8)))),
                          onPressed: () =>
                              _selectDate(context, isStartDate: true),
                          child: Text(
                            manualInputProvider.startDate == null
                                ? "시작일"
                                : DateFormat('yyyy-MM-dd')
                                .format(manualInputProvider.startDate!),
                            style: TextStyle(color: Color(0xFFD5D8DD)),
                          ),
                        ),
                        TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Color(0xFFD5D8DD),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8)))),
                          onPressed: () =>
                              _selectDate(context, isStartDate: false),
                          child: Text(
                            manualInputProvider.endDate == null
                                ? "종료일"
                                : DateFormat('yyyy-MM-dd')
                                .format(manualInputProvider.endDate!),
                            style: TextStyle(color: Color(0xFFD5D8DD)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectPeriod(BuildContext context) async {
    final List<String> periods = ["오전", "오후"];
    String? result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0),
          backgroundColor: Colors.white,
          children: periods.map((period) {
            return SimpleDialogOption(
              onPressed: () => Navigator.pop(context, period),
              child: Text(
                period,
                textAlign: TextAlign.center,
              ),
            );
          }).toList(),
        );
      },
    );

    if (result != null) {
      setState(() {
        final manualInputProvider =
        Provider.of<ManualinputProvider>(context, listen: false);
        manualInputProvider.setPeriod(result);
      });
    }
  }

  void _selectHour(BuildContext context) async {
    final List<int> hours = List.generate(12, (index) => index + 1);
    int? result = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: 85,
          height: 650,
          child: SimpleDialog(
            backgroundColor: Colors.white,
            children: hours.map((hour) {
              return SimpleDialogOption(
                onPressed: () => Navigator.pop(context, hour),
                child: Text(hour.toString().padLeft(2, '0')),
              );
            }).toList(),
          ),
        );
      },
    );

    if (result != null) {
      setState(() {
        final manualInputProvider =
        Provider.of<ManualinputProvider>(context, listen: false);
        manualInputProvider.setHour(result);
      });
    }
  }

  void _selectMinute(BuildContext context) async {
    final List<int> minutes = List.generate(12, (index) => index * 5);
    int? result = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: Colors.white,
          children: minutes.map((minute) {
            return SimpleDialogOption(
              onPressed: () => Navigator.pop(context, minute),
              child: Text(minute.toString().padLeft(2, '0')),
            );
          }).toList(),
        );
      },
    );

    if (result != null) {
      setState(() {
        final manualInputProvider =
        Provider.of<ManualinputProvider>(context, listen: false);
        manualInputProvider.setMinute(result);
      });
    }
  }

  void _selectDate(BuildContext context, {required bool isStartDate}) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        final manualInputProvider =
        Provider.of<ManualinputProvider>(context, listen: false);
        if (isStartDate) {
          manualInputProvider.setStartDate(picked);
        } else {
          manualInputProvider.setEndDate(picked);
        }
      });
    }
  }
}
