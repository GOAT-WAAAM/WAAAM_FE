import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ReviewPeriod extends StatefulWidget {
  const ReviewPeriod({super.key});

  @override
  State<ReviewPeriod> createState() => _ReviewPeriodState();
}

class _ReviewPeriodState extends State<ReviewPeriod> {
  DateTime? startDate;
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: _buildDatePickerBox(
                  label: startDate != null ? _formatDate(startDate!) : '시작일',
                  onTap: () => _selectDate(isStartDate: true),
                  textColor: Color(0xFFD5D8DD), // 라벨 텍스트 색상
                  textSize: 14, // 라벨 벨 텍스트 크기
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '~', // ~ 문자
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildDatePickerBox(
                  label: endDate != null ? _formatDate(endDate!) : '종료일',
                  onTap: () => _selectDate(isStartDate: false),
                  textColor: Color(0xFFD5D8DD), // 라벨 텍스트 색상
                  textSize: 14, // 라벨 텍스트 크기
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (startDate != null && endDate != null)
            Container(
              height: 400, // Adjust the height as needed
              child: TableCalendar(
                focusedDay: DateTime.now(),
                firstDay: DateTime(DateTime.now().year - 1),
                lastDay: DateTime(DateTime.now().year + 1),
                selectedDayPredicate: (day) {
                  return (startDate != null && endDate != null) &&
                      day.isAfter(startDate!.subtract(Duration(days: 1))) &&
                      day.isBefore(endDate!.add(Duration(days: 1)));
                },
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  defaultDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  markerDecoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.3),
                    shape: BoxShape.rectangle,
                  ),
                ),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    if (startDate == null) {
                      startDate = selectedDay;
                      endDate = null;
                    } else if (endDate == null) {
                      endDate = selectedDay.isAfter(startDate!)
                          ? selectedDay
                          : startDate;
                      startDate = selectedDay.isBefore(startDate!)
                          ? selectedDay
                          : startDate;
                    } else {
                      startDate = selectedDay;
                      endDate = null;
                    }
                  });
                },
                rangeStartDay: startDate,
                rangeEndDay: endDate,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDatePickerBox({
    required String label,
    required VoidCallback onTap,
    required Color textColor,
    required double textSize,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 42, // Height set to 42px
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: textSize, // 라벨 텍스트 크기
              fontWeight: FontWeight.w500,
              color: textColor, // 라벨 텍스트 색상
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate({required bool isStartDate}) async {
    final DateTime initialDate = isStartDate ? (startDate ?? DateTime.now()) : (endDate ?? DateTime.now());
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 10),
      lastDate: DateTime(DateTime.now().year + 10),
    );

    if (selectedDate != null) {
      setState(() {
        if (isStartDate) {
          if (endDate != null && selectedDate.isAfter(endDate!)) {
            endDate = selectedDate;
          }
          startDate = selectedDate;
        } else {
          if (startDate != null && selectedDate.isBefore(startDate!)) {
            startDate = selectedDate;
          }
          endDate = selectedDate;
        }
      });
    }
  }

  String _formatDate(DateTime date) {
    // Format the date as yyyy-mm-dd
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
