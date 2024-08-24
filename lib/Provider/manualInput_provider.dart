import 'package:flutter/material.dart';

class ManualinputProvider extends ChangeNotifier{
  List<String> _weekdays = [''];
  String _period = '';
  int _hour = 0;
  int _minute = 0;
  DateTime? _startDate;
  DateTime? _endDate;

  List<String> get weekdays => _weekdays;
  String get period => _period;
  int get hour => _hour;
  int get minute => _minute;
  DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;

  void setWeekdays(List<String> weekdays){
    _weekdays = weekdays;
    notifyListeners();
  }
  void setPeriod(String period){
    _period = period;
    notifyListeners();
  }

  void setHour(int hour){
    _hour = hour;
    notifyListeners();
  }

  void setMinute(int minute){
    _minute = minute;
    notifyListeners();
  }

  void setStartDate(DateTime? startDate){
    _startDate = startDate;
    notifyListeners();
  }

  void setEndDate(DateTime? endDate){
    _endDate = endDate;
    notifyListeners();
  }

  }


