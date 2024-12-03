import 'package:Lavapp/components/app_bar.dart';
import 'package:Lavapp/components/custom_popup.dart';
import 'package:Lavapp/utils/colors.dart';
import 'package:flutter/material.dart';

class LiveMachinesPage extends StatelessWidget {
  final String time;

  LiveMachinesPage({required this.time});

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMachineStatusCard('Lavadora', 2),
                _buildMachineStatusCard('Secadora', 1),
              ],
            ),
            const SizedBox(height: 16),
            _buildLegend(),
            const SizedBox(height: 16),
            Expanded(child: _buildMachineList()),
          ],
        ),
      ),
    );
  }

  Widget _buildMachineStatusCard(String type, int available) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.darkBlue,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  type == 'Lavadora'
                      ? Icons.local_laundry_service
                      : Icons.dry_cleaning,
                  color: Colors.white,
                  size: 40,
                ),
                const SizedBox(width: 8),
                Text(
                  type,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '$available Livres',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      children: [
        _buildLegendItem(Colors.green, 'Disponível'),
        const SizedBox(width: 16),
        _buildLegendItem(Colors.red, 'Ocupado'),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        CircleAvatar(
          radius: 8,
          backgroundColor: color,
        ),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }

  void _scheduleAppointment(BuildContext context, String time) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Borda arredondada
        ),
        elevation: 5,
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título do Pop-up
              const Center(
                child: Text(
                  'Atenção',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.orange,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  'Deseja agendar o horário de $time?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.black,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                      backgroundColor: const WidgetStatePropertyAll(
                        AppColors.lightBlue,
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    child: Text(
                      'Cancelar',
                      style: TextStyle(fontSize: 16, color: AppColors.black),
                    ),
                  ),
                  const SizedBox(width: 24),
                  ElevatedButton(
                    onPressed: () {
                      showWarningDialog(
                        context,
                        'O horário de $time foi agendado com sucesso!',
                        () {
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: const WidgetStatePropertyAll(
                        AppColors.darkBlue,
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    child: Text(
                      'Agendar',
                      style: TextStyle(fontSize: 16, color: AppColors.black),
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

  Widget _buildMachineList() {
    final machines = [
      {'name': 'Lavadora L1', 'status': true},
      {'name': 'Lavadora L2', 'status': true},
      {'name': 'Lavadora L3', 'status': false},
      {'name': 'Secadora S1', 'status': true},
    ];

    return ListView.builder(
      itemCount: machines.length,
      itemBuilder: (context, index) {
        final machine = machines[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () => _scheduleAppointment(context, time),
            style: ButtonStyle(
              padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.all(24)),
              backgroundColor: WidgetStateProperty.all<Color>(AppColors.white),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              elevation: WidgetStateProperty.all<double>(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      (machine['name'] as String).contains('Lavadora')
                          ? Icons.local_laundry_service
                          : Icons.dry_cleaning,
                      color: AppColors.darkBlue,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      (machine['name'] as String),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 8,
                  backgroundColor:
                      machine['status'] != null ? Colors.green : Colors.red,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
