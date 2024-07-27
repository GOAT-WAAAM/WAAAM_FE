import 'package:flutter/material.dart';

enum Days { Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday }

class SelectDays extends StatefulWidget {
  const SelectDays({super.key});

  @override
  State<SelectDays> createState() => _SelectDaysState();
}

class _SelectDaysState extends State<SelectDays> {
  Set<Days> filters = <Days>{};

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Wrap(
              spacing: 1,
              children: Days.values.map((Days day) {
                final bool isSelected=filters.contains(day);
                return FilterChip(
                  backgroundColor: Colors.white,
                  showCheckmark: false,
                  selectedColor: Colors.black,
                  shape: const CircleBorder(
                      side: BorderSide(color: Color(0xFFD5D8DD))),
                  label: Text(
                    _dayToString(day),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontFamily: 'Pretendard',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  selected:isSelected,
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
        ));
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