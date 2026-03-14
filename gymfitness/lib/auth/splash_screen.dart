import 'dart:async';
import 'package:flutter/material.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _leftController;
  late AnimationController _rightController;
  late Animation<Offset> _gymOffset;
  late Animation<Offset> _fitnessOffset;

  @override
  void initState() {
    super.initState();

    _leftController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _rightController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _gymOffset = Tween<Offset>(
      begin: const Offset(-1.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _leftController, curve: Curves.easeOut));

    _fitnessOffset = Tween<Offset>(
      begin: const Offset(1.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _rightController, curve: Curves.easeOut));

    _leftController.forward();
    _rightController.forward();

    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => WelcomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _leftController.dispose();
    _rightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/image8.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(color: Colors.black.withOpacity(0.5)),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SlideTransition(
                  position: _gymOffset,
                  child: const Text(
                    "GYM ",
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SlideTransition(
                  position: _fitnessOffset,
                  child: const Text(
                    "FITNESS",
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
