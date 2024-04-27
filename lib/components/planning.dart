import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:valetclub_valet/common/theme.dart';

class PlanningScreen extends StatefulWidget {
  const PlanningScreen({
    super.key,
  });

  @override
  State<PlanningScreen> createState() => _PlanningScreenState();
}

class _PlanningScreenState extends State<PlanningScreen> {
  int _selectedYear = DateTime.now().year;
  int _selectedMonth = DateTime.now().month;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MainTheme.secondaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.menu, color: MainTheme.darkColor),
              onPressed: () {
                // Handle burger menu icon tap
              },
            ),
            IconButton(
              icon: const Icon(Icons.edit_calendar_outlined,
                  color: MainTheme.mainColor),
              onPressed: () {
                // Handle plus calendar icon tap
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: MainTheme.secondaryColor,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Calendar
              buildCalendar(),
              // Weeks
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: MainTheme.mainColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '${_getMonthName(_selectedMonth)} $_selectedYear',
                          style: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: MainTheme.secondaryColor,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        // Sample week
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: MainTheme.secondaryColor.withOpacity(.9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Week 1',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '15:30 - 17:00',
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: MainTheme.warningColor.withOpacity(.9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Week 2',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '08:30 - 13:00',
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Add more weeks here
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: MainTheme.mainColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '${_getMonthName(_selectedMonth)} $_selectedYear',
                          style: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: MainTheme.secondaryColor,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        // Sample week
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: MainTheme.errorColor.withOpacity(.9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Week 1',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '15:30 - 17:00',
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: MainTheme.thirdColor.withOpacity(.9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Week 2',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '08:30 - 13:00',
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Add more weeks here
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCalendar() {
    return Container(
      decoration: BoxDecoration(
        color: MainTheme.greyColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _selectedMonth--;
                    if (_selectedMonth < 1) {
                      _selectedMonth = 12;
                      _selectedYear--;
                    }
                  });
                },
                icon: const Icon(Icons.keyboard_arrow_left),
              ),
              Text(
                '${_getMonthName(_selectedMonth)} $_selectedYear',
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: MainTheme.mainColor,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _selectedMonth++;
                    if (_selectedMonth > 12) {
                      _selectedMonth = 1;
                      _selectedYear++;
                    }
                  });
                },
                icon: const Icon(Icons.keyboard_arrow_right),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          const SizedBox(height: 10.0),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                _daysInMonth(_selectedYear, _selectedMonth),
                (index) {
                  final dayNumber = index + 1;
                  final dayOfWeek =
                      DateTime(_selectedYear, _selectedMonth, dayNumber)
                          .weekday;
                  final isCurrentDay = _isCurrentDay(dayNumber);
                  return Container(
                    width: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isCurrentDay
                          ? MainTheme.greyColor.withOpacity(0.5)
                          : null,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${_getWeekDayName(dayOfWeek)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isCurrentDay ? Colors.white : null,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '$dayNumber',
                          style: TextStyle(
                            fontSize: 18,
                            color: isCurrentDay ? Colors.white : null,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

// Detecting the Current day
  bool _isCurrentDay(int day) {
    final now = DateTime.now();
    return now.year == _selectedYear &&
        now.month == _selectedMonth &&
        now.day == day;
  }

// Getting weekday name from int value
  String _getWeekDayName(int weekDay) {
    switch (weekDay) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  bool _isCurrentWeek(int index) {
    final currentDay = DateTime.now();
    final firstDayOfMonth = DateTime.utc(_selectedYear, _selectedMonth, 1);
    final daysInMonth = _daysInMonth(_selectedYear, _selectedMonth);

    if (index < firstDayOfMonth.weekday - 1 ||
        index >= daysInMonth + firstDayOfMonth.weekday - 1) {
      return false;
    }

    final day = firstDayOfMonth
        .add(Duration(days: index - firstDayOfMonth.weekday + 1));
    return day.year == currentDay.year &&
        day.month == currentDay.month &&
        day.day == currentDay.day;
  }

  int _daysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  // Getting month name from int value

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }
}
