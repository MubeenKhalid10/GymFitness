import 'package:flutter/material.dart';

class WorkoutDetailScreen extends StatelessWidget {
  final String workoutName;
  final String imagePath;

  const WorkoutDetailScreen({
    super.key,
    required this.workoutName,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(workoutName),
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: [
          Image.asset(
            imagePath,
            height: 250,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 20),
          Text(
            workoutName,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Workout details and instructions will appear here...',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
