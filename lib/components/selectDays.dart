import 'package:flutter/material.dart';

enum Days { Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday }

class SelectDays extends StatefulWidget {
  const SelectDays({super.key});

  @override
  State<SelectDays> createState() => _SelectDaysState();
}

class _SelectDaysState extends State<SelectDays> {
  Set<Days> filters = <Days>{};
  DateTime? startDate;
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () async {
              final DateTimeRange? picked = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
              );
              if (picked != null) {
                setState(() {
                  startDate = picked.start;
                  endDate = picked.end;
                });
              }
            },
            child: Text('날짜 선택'),
          ),
          if (startDate != null && endDate != null) ...[
            Text('시작일: ${_formatDate(startDate!)}'),
            Text('종료일: ${_formatDate(endDate!)}'),
            Wrap(
              spacing: 1,
              children: Days.values.map((Days day) {
                final bool isSelected = filters.contains(day);
                return FilterChip(
                  backgroundColor: Colors.white,
                  showCheckmark: false,
                  selectedColor: Color(0xFFE9F9F8),
                  shape: isSelected
                      ? CircleBorder(
                    side: BorderSide(color: Color(0xFF8AE5E4)),
                  )
                      : CircleBorder(
                    side: BorderSide(color: Color(0xFFD5D8DD)),
                  ),
                  label: Text(
                    _dayToString(day),
                    style: TextStyle(
                      color: isSelected ? Color(0xFF8AE5E4) : Colors.black,
                      fontFamily: 'Pretendard',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        filters.add(day);
                      } else {
                        filters.remove(day);
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ],
        ],
      ),
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

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month}-${date.day}';
  }
}
