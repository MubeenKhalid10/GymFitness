import 'dart:async';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> _images = [
    'assets/wel1.jpg',
    'assets/wel2.jpg',
    'assets/wel3.jpg',
    'assets/well4.jpg',
    'assets/wel5.jpg',
  ];

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      int nextPage = (_currentPage + 1) % _images.length;
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
      setState(() => _currentPage = nextPage);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fullscreen image slider
          PageView.builder(
            controller: _pageController,
            itemCount: _images.length,
            itemBuilder: (context, index) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(_images[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),

          // Dark overlay for better contrast
          Container(color: Colors.black.withOpacity(0.6)),

          // Bottom section with dots and button
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Slide indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_images.length, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
                    height: 10,
                    width: _currentPage == index ? 20 : 10,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? Colors.redAccent
                          : Colors.white54,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  );
                }),
              ),

              // Get Started button
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.redAccent,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  },
                  child:
                      const Text("Get Started", style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
