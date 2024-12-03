import 'dart:async';
import 'package:flutter/material.dart';
import 'schedule_page.dart';
import 'package:Lavapp/pages/my_schedule_page.dart';
import 'package:Lavapp/utils/colors.dart';
import 'package:Lavapp/components/app_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> statusItems = ['Lavagem 1', 'Lavagem 2', 'Lavagem 3'];
  final List<String> agendamentoItems = [
    '04/12 - 12:30',
    '05/12 - 14:00',
    '06/12 - 10:00'
  ];

  String _getGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour < 18) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  Duration remainingTime = Duration(minutes: 29, seconds: 59);
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTime.inSeconds > 0) {
          remainingTime = remainingTime - const Duration(seconds: 1);
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _getGreeting(),
              style: const TextStyle(
                color: AppColors.gray,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Usuário',
              style: TextStyle(
                fontSize: 24,
                color: AppColors.darkBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.lightBlue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'R\$ 00,00',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                _buildSectionTitle('Status da lavagem'),
                const SizedBox(height: 8),
                _buildStatusLavagem(context, statusItems),
                const SizedBox(height: 16),
                _buildSectionTitle('Agenda'),
                const SizedBox(height: 8),
                _buildAgenda(context),
                const SizedBox(height: 16),
                _buildSectionTitle('Meus agendamentos'),
                const SizedBox(height: 8),
                _buildAgendamentos(context, agendamentoItems),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        color: AppColors.orange,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildStatusLavagem(BuildContext context, List<String> items) {
    return Column(
      children: items
          .map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: _buildLavagemItem(context, item),
              ))
          .toList(),
    );
  }

  Widget _buildAgendamentos(BuildContext context, List<String> items) {
    return Column(
      children: items
          .map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: _buildAgendamentoItem(context, item),
              ))
          .toList(),
    );
  }

  Widget _buildLavagemItem(BuildContext context, String title) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(blurRadius: 4, color: Colors.grey.withOpacity(0.5)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16)),
          _buildTimeRemaining(),
        ],
      ),
    );
  }

  Widget _buildAgendamentoItem(BuildContext context, String scheduleTime) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(blurRadius: 4, color: Colors.grey.withOpacity(0.5)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Agendado para:', style: TextStyle(fontSize: 16)),
          _buildTimeScheduled(context, scheduleTime),
        ],
      ),
    );
  }

  Widget _buildTimeRemaining() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        backgroundColor: AppColors.lightBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: () {},
      child: Text(
        '${remainingTime.inMinutes}:${(remainingTime.inSeconds % 60).toString().padLeft(2, '0')} min',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildTimeScheduled(BuildContext context, String scheduleTime) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        backgroundColor: AppColors.lightBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MySchedulePage()),
        );
      },
      child: Text(
        scheduleTime,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildAgenda(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildAgendaButton(context, 'Agendar lavadora'),
          const SizedBox(height: 16),
          _buildAgendaButton(context, 'Agendar secadora'),
        ],
      ),
    );
  }

  Widget _buildAgendaButton(BuildContext context, String label) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SchedulePage()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkBlue,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      child: Text(label, style: const TextStyle(fontSize: 16)),
    );
  }
}
