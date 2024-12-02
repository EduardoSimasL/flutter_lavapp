import 'package:Lavapp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/navigation_bloc.dart';
import 'blocs/navigation_event.dart';
import 'blocs/navigation_state.dart';
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
    _scheduleAppointment(time);
  }

  void _scheduleAppointment(String time) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Agendamento Confirmado'),
        content: Text('Seu horário de $time foi agendado com sucesso!'),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(150.0), // Aumentando a altura da AppBar
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white, // Cor da AppBar
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 4), // Sombra na parte de baixo
              ),
            ],
          ),
          child: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
                //BlocProvider.of<NavigationBloc>(context).add(NavigateToHomePage());
              },
            ),
            backgroundColor: AppColors
                .white, // Deixa transparente para o Container cuidar da cor
            elevation: 0, // Remove a sombra padrão da AppBar
            flexibleSpace: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Agenda',
                      style: TextStyle(
                          fontSize: 24,
                          color: AppColors.orange,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
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
                      color: Colors.blue,
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
