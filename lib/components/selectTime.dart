import 'package:flutter/material.dart';

class SelectTimes extends StatefulWidget {
  const SelectTimes({super.key});

  @override
  State<SelectTimes> createState() => _SelectTimesState();
}

class _SelectTimesState extends State<SelectTimes> {
  String? selectedPeriod;
  int? selectedHour;
  int? selectedMinute;
  List<String> selectedTimes = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: _buildDropdownBox(
                label: selectedPeriod ?? '오전/오후',
                items: ['오전', '오후'],
                onChanged: (String? newValue) {
                  setState(() {
                    selectedPeriod = newValue;
                  });
                },
                value: selectedPeriod,
                hintColor: Colors.grey,
                valueColor: Colors.black,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildDropdownBox(
                label: selectedHour != null ? '$selectedHour' : '00',
                items: List.generate(12, (index) => index + 1),
                onChanged: (int? newValue) {
                  setState(() {
                    selectedHour = newValue;
                  });
                },
                value: selectedHour,
                hintColor: Colors.grey,
                valueColor: Colors.black,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              ':',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildDropdownBox(
                label: selectedMinute != null ? '${selectedMinute!}' : '00',
                items: List.generate(12, (index) => index * 5),
                onChanged: (int? newValue) {
                  setState(() {
                    selectedMinute = newValue;
                    // Automatically add the selected time to the list
                    if (selectedHour != null && selectedMinute != null && selectedPeriod != null) {
                      final time = '${selectedPeriod} ${selectedHour}시 ${selectedMinute}분';
                      selectedTimes.add(time);
                      // Reset selections
                      selectedPeriod = null;
                      selectedHour = null;
                      selectedMinute = null;
                    }
                  });
                },
                value: selectedMinute,
                hintColor: Colors.grey,
                valueColor: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: selectedTimes.length,
          itemBuilder: (context, index) {
            final time = selectedTimes[index];
            final parts = time.split(' ');
            final period = parts[0];
            final hour = parts[1].replaceAll('시', '');
            final minute = parts[2].replaceAll('분', '');

            return Container(
              height: 42, // Height set to 42px
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: _buildBox(label: period),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildBox(label: hour),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    ':',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildBox(label: minute),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildBox({required String label}) {
    return Container(
      height: 42, // Height set to 42px
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownBox<T>({
    required String label,
    required List<T> items,
    required ValueChanged<T?> onChanged,
    required T? value,
    required Color hintColor,
    required Color valueColor,
  }) {
    return DropdownButtonHideUnderline(
      child: Container(
        height: 42, // Height set to 42px
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: DropdownButton<T>(
          value: value,
          items: items.map<DropdownMenuItem<T>>((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(item.toString()),
            );
          }).toList(),
          onChanged: onChanged,
          dropdownColor: Colors.white,
          isExpanded: true,
          hint: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: hintColor,
            ),
          ),
          selectedItemBuilder: (BuildContext context) {
            return items.map<DropdownMenuItem<T>>((T item) {
              return DropdownMenuItem<T>(
                value: item,
                child: Text(item.toString()),
              );
            }).toList();
          },
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: valueColor,
          ),
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.transparent,
          ),
          itemHeight: 48.0,
        ),
      ),
    );
  }
}
