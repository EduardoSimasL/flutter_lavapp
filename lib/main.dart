import 'package:Lavapp/pages/live_machines_page.dart';
import 'package:Lavapp/pages/my_schedule_page.dart';
import 'package:Lavapp/pages/schedule_page.dart';
import 'package:Lavapp/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/navigation_bloc.dart';
import 'blocs/navigation_state.dart';
import 'pages/home_page.dart';

void main() {
  runApp(LavanderiaApp());
}

class LavanderiaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lavapp',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Poppins',
        ),
        home: BlocListener<NavigationBloc, NavigationState>(
          listener: (context, state) {
            if (state is ScheduleState) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SchedulePage()),
              );
            } else if (state is LiveMachinesState) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LiveMachinesPage(
                          time: '',
                        )),
              );
            } else if (state is MyScheduleState) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MySchedulePage()),
              );
            } else if (state is HomeState) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
                (route) => false,
              );
            }
          },
          child: SplashScreen(),
        ),
      ),
    );
  }
}
