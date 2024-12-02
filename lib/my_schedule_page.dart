// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:Lavapp/blocs/navigation_state.dart';
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
      appBar: AppBar(
        title: Text("Meus Agendamentos"),
      ),
      body: ListView.builder(
        itemCount: agendamentos.length, // Número de itens na lista
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(agendamentos[index]),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  // Excluir agendamento e atualizar a lista
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
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
