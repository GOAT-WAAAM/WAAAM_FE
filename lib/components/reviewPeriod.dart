import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // 날짜 포맷을 위한 패키지

class ReviewPeriod extends StatefulWidget {
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final Function(DateTime?, DateTime?) onDateRangeSelected;

  const ReviewPeriod({
    Key? key,
    this.initialStartDate,
    this.initialEndDate,
    required this.onDateRangeSelected,
  }) : super(key: key);

  @override
  _ReviewPeriodState createState() => _ReviewPeriodState();
}

class _ReviewPeriodState extends State<ReviewPeriod> {
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    super.initState();
    startDate = widget.initialStartDate;
    endDate = widget.initialEndDate;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: _buildDatePickerBox(
                  label: startDate != null ? _formatDate(startDate!) : '시작일',
                  onTap: () => _showDateRangePicker(context, isStartDate: true),
                  textColor: const Color(0xFFD5D8DD),
                  textSize: 14,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '~',
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
                  onTap: () => _showDateRangePicker(context, isStartDate: false),
                  textColor: const Color(0xFFD5D8DD),
                  textSize: 14,
                ),
              ),
            ],
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
        height: 42,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: textSize,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showDateRangePicker(BuildContext context, {required bool isStartDate}) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDateRange: (startDate != null && endDate != null)
          ? DateTimeRange(start: startDate!, end: endDate!)
          : null,
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          if (endDate != null && picked.start.isAfter(endDate!)) {
            endDate = picked.start;
          }
          startDate = picked.start;
        } else {
          if (startDate != null && picked.end.isBefore(startDate!)) {
            startDate = picked.end;
          }
          endDate = picked.end;
        }
      });

      widget.onDateRangeSelected(startDate, endDate);
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }
}
