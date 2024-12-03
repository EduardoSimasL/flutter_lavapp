// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:Lavapp/blocs/navigation_state.dart';
import 'package:Lavapp/components/app_bar.dart';
import 'package:Lavapp/utils/colors.dart';
import 'package:flutter/material.dart';

class MySchedulePage extends StatefulWidget {
  @override
  _MySchedulePageState createState() => _MySchedulePageState();
}

class _MySchedulePageState extends State<MySchedulePage> {
  // Lista dinâmica de agendamentos
  List<String> agendamentos = [
    "04/12 - 12:30",
    "05/12 - 14:00",
    "09/12 - 10:00",
  ];

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
                'Meus Agendamentos',
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
        padding: const EdgeInsets.only(top: 16.0),
        child: ListView.builder(
          itemCount: agendamentos.length, // Número de itens na lista
          itemBuilder: (context, index) {
            return Card(
              elevation: 2,
              color: AppColors.white,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                title: Text(agendamentos[index]),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _scheduleRemoveAppointment(context, index);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _scheduleRemoveAppointment(BuildContext context, int index) {
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
              const Center(
                child: Text(
                  'Deseja cancelar o agendamento?',
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
                      'Não',
                      style: TextStyle(fontSize: 16, color: AppColors.black),
                    ),
                  ),
                  const SizedBox(width: 24),
                  ElevatedButton(
                    onPressed: () {
                      _removeAppointment(context, index);
                      Navigator.pop(context);
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
                      'Sim',
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

  void _removeAppointment(BuildContext context, int index) {
    setState(() {
      print("Excluir agendamento: ${agendamentos[index]}");
      agendamentos.removeAt(index);
    });

    // Exemplo de lógica para estado/navegação
    var state; // Representação de estado externo
    if (state is MyScheduleState) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MySchedulePage()),
      );
    } else {
      print("Estado não corresponde a MyScheduleState.");
    }
  }
}
