import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/navigation_bloc.dart';
import 'blocs/navigation_event.dart';
import 'blocs/navigation_state.dart';
import 'schedule_page.dart';
import 'live_machines_page.dart';
import 'package:Lavapp/utils/colors.dart';

class HomePage extends StatelessWidget {
  final List<String> statusItems = ['Lavagem 1', 'Lavagem 2', 'Lavagem 3'];
  final List<String> agendamentoItems = [
    '04/12 - 12:30',
    '05/12 - 14:00',
    '06/12 - 10:00'
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationBloc, NavigationState>(
      listener: (context, state) {
        if (state is ScheduleState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SchedulePage()),
          );
        } else if (state is LiveMachinesState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LiveMachinesPage()),
          );
        } else if (state is HomeState) {
          Navigator.popUntil(context, (route) => route.isFirst);
        }
      },
      child: Scaffold(
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
              backgroundColor: AppColors
                  .white, // Deixa transparente para o Container cuidar da cor
              elevation: 0, // Remove a sombra padrão da AppBar
              flexibleSpace: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Good Morning',
                        style: TextStyle(
                          color: AppColors.gray,
                          fontWeight: FontWeight.bold,
                        )),
                    const Text('Usuário',
                        style: TextStyle(
                            fontSize: 24,
                            color: AppColors.darkBlue,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.lightBlue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text('R\$ 00,00',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
              left: 10.0, right: 10.0, bottom: 16.0, top: 0),
          child: SingleChildScrollView(
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
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(blurRadius: 4, color: Colors.grey.withOpacity(0.5))
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16)),
          _buildTimeRemaining(context),
        ],
      ),
    );
  }

  Widget _buildAgendamentoItem(BuildContext context, String scheduleTime) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(blurRadius: 4, color: Colors.grey.withOpacity(0.5))
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

  Widget _buildTimeRemaining(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        backgroundColor: AppColors.lightBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: () {
        // Adicione a ação aqui
        BlocProvider.of<NavigationBloc>(context)
            .add(NavigateToMySchedulePage());
      },
      child: const Text(
        'faltam 29:53 min',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildTimeScheduled(BuildContext context, String scheduleTime) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        backgroundColor: AppColors.lightBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: () {
        // Adicione a ação aqui
        BlocProvider.of<NavigationBloc>(context)
            .add(NavigateToLiveMachinesPage());
      },
      child: Text(
        scheduleTime,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildAgenda(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
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
        crossAxisAlignment: CrossAxisAlignment.center,
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
        // Ação do botão
        BlocProvider.of<NavigationBloc>(context).add(NavigateToSchedulePage());
        print('$label pressionado');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkBlue,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
