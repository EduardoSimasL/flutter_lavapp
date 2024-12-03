import 'package:flutter/material.dart';
import 'package:Lavapp/utils/colors.dart';
import 'package:Lavapp/pages/login_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Inicializa o AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(); 

    // Navega para a LoginPage após 2 segundos
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlue,
      body: Center(
        child: RotationTransition(
          turns: _controller, 
          child: Image.asset(
            'assets/image/logo.png', 
            width: 200, 
            height: 200,
          ),
        ),
      ),
    );
  }
}
