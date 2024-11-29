import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/navigation_bloc.dart';
import 'blocs/navigation_event.dart';
import 'blocs/navigation_state.dart';
// import 'schedule_page.dart';
// import 'live_machines_page.dart'; 
import 'home_page.dart';

void main() {
  runApp(LavanderiaApp());
}

class LavanderiaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lavanderia Agenda',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white, // Definindo a cor de fundo
      ),
      home: BlocProvider(
        create: (context) => NavigationBloc(),
        child: HomePage(),
      ),
    );
  }
}
