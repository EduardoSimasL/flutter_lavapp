import 'package:Lavapp/components/app_bar.dart';
import 'package:Lavapp/pages/live_machines_page.dart';
import 'package:Lavapp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final List<String> defaultTimes = [
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '01:00 PM',
    '02:00 PM',
    '03:00 PM'
  ];

  final Map<DateTime, List<String>> _availableTimes = {};
  final Map<DateTime, String?> _selectedTimes = {};

  @override
  void initState() {
    super.initState();
    _initializeAvailableTimes();
  }

  void _initializeAvailableTimes() {
    DateTime start = DateTime(DateTime.now().year, 1, 1);
    DateTime end = DateTime(DateTime.now().year, 12, 31);
    for (DateTime day = start;
        day.isBefore(end.add(Duration(days: 1)));
        day = day.add(Duration(days: 1))) {
      _availableTimes[DateUtils.dateOnly(day)] = List.from(defaultTimes);
      _selectedTimes[DateUtils.dateOnly(day)] = null;
    }
  }

  List<String> getTimesForSelectedDay(DateTime day) {
    return _availableTimes[DateUtils.dateOnly(day)] ?? [];
  }

  void _selectTime(String time) {
    setState(() {
      _selectedTimes[DateUtils.dateOnly(_selectedDay!)] = time;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LiveMachinesPage(time: time),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'Agenda',
                style: TextStyle(
                  fontSize: 24,
                  color: AppColors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              color: AppColors.white,
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = DateTime(
                        selectedDay.year,
                        selectedDay.month,
                        selectedDay.day,
                      ); // Garantindo que não haja diferença de horário
                      _focusedDay = focusedDay;
                    });
                  },
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                  calendarStyle: CalendarStyle(
                    selectedDecoration: BoxDecoration(
                      color: AppColors.lightBlue,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: Colors.blue.shade200,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            if (_selectedDay != null)
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Horários disponíveis para ${_selectedDay!.toLocal().toString().split(' ')[0]}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    Expanded(
                      child: ListView.builder(
                        itemCount: getTimesForSelectedDay(_selectedDay!).length,
                        itemBuilder: (context, index) {
                          final time =
                              getTimesForSelectedDay(_selectedDay!)[index];
                          final isSelected = _selectedTimes[
                                  DateUtils.dateOnly(_selectedDay!)] ==
                              time;
                          return Card(
                            color: AppColors.white,
                            margin: EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 8.0),
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ListTile(
                              title: Text(time),
                              trailing: isSelected
                                  ? Icon(Icons.check, color: Colors.green)
                                  : null,
                              onTap: () => _selectTime(time),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            else
              Center(
                  child: Text(
                      'Selecione um dia para ver os horários disponíveis')),
          ],
        ),
      ),
    );
  }
}
