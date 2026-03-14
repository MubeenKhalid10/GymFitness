import 'dart:async';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'notifications_screen.dart';
import 'profile_screen.dart';
import 'exercise_screen.dart';
import 'analysis_screen.dart';
import 'workout_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  int _selectedIndex = 0;

  final List<Map<String, String>> featuredExercises = [
    {'image': 'assets/pushups.jpg', 'name': 'Push Ups'},
    {'image': 'assets/squats.jpg', 'name': 'Squats'},
    {'image': 'assets/plank.jpg', 'name': 'Plank'},
  ];

  final List<Map<String, String>> popularWorkouts = [
    {'image': 'assets/benchpress.jpg', 'name': 'Bench Press'},
    {'image': 'assets/deadlift.jpg', 'name': 'Deadlift'},
    {'image': 'assets/lunges.jpg', 'name': 'Lunges'},
  ];

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    String username =
        Supabase.instance.client.auth.currentUser?.email?.split('@')[0] ??
            'User';

    _screens = [
      HomeContentScreen(
        username: username,
        pageController: _pageController,
        currentPage: _currentPage,
        featuredExercises: featuredExercises,
        popularWorkouts: popularWorkouts,
      ),
      ExerciseScreen(),
      AnalysisScreen(),
      const ProfileScreen(),
    ];

    Timer.periodic(const Duration(seconds: 4), (timer) {
      _currentPage = (_currentPage + 1) % featuredExercises.length;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      setState(() {});
    });
  }

  void _onNavTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey,
        onTap: _onNavTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center), label: 'Exercise'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart), label: 'Analysis'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class HomeContentScreen extends StatelessWidget {
  final String username;
  final PageController pageController;
  final int currentPage;
  final List<Map<String, String>> featuredExercises;
  final List<Map<String, String>> popularWorkouts;

  const HomeContentScreen({
    required this.username,
    required this.pageController,
    required this.currentPage,
    required this.featuredExercises,
    required this.popularWorkouts,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting and Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Good Morning 👋',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    Text(username,
                        style:
                            TextStyle(fontSize: 18, color: Colors.grey[600])),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.notifications_none),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => NotificationsScreen()),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.person_outline),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ProfileScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Search
            TextField(
              decoration: InputDecoration(
                hintText: "What do you want to learn today?",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Featured Exercises
            SizedBox(
              height: 220,
              child: PageView.builder(
                controller: pageController,
                itemCount: featuredExercises.length,
                itemBuilder: (context, index) {
                  final exercise = featuredExercises[index];
                  return Container(
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: AssetImage(exercise['image']!),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: const LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [Colors.black54, Colors.transparent],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 16,
                          bottom: 70,
                          child: Text(
                            exercise['name']!,
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Positioned(
                          left: 16,
                          bottom: 10,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent),
                            onPressed: () {},
                            child: const Text("Explore NOW"),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),

            // Slide Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(featuredExercises.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: currentPage == index ? 20 : 10,
                  decoration: BoxDecoration(
                    color:
                        currentPage == index ? Colors.redAccent : Colors.grey,
                    borderRadius: BorderRadius.circular(5),
                  ),
                );
              }),
            ),
            const SizedBox(height: 30),

            // Popular Workouts
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Popular Workouts",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {},
                  child: const Text("See more",
                      style: TextStyle(color: Colors.redAccent)),
                )
              ],
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: popularWorkouts.length,
                itemBuilder: (context, index) {
                  final workout = popularWorkouts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => WorkoutDetailScreen(
                            workoutName: workout['name']!,
                            imagePath: workout['image']!,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 160,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: AssetImage(workout['image']!),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: const LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [Colors.black45, Colors.transparent],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 10,
                            bottom: 10,
                            child: Text(
                              workout['name']!,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
