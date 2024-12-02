import 'package:Lavapp/components/app_bar.dart';
import 'package:Lavapp/utils/colors.dart';
import 'package:flutter/material.dart';

class LiveMachinesPage extends StatelessWidget {
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
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 4,
                offset: const Offset(0, 4),
              ),
            ],
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
        );
      },
    );
  }
}
