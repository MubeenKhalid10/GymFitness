import 'package:flutter/material.dart';

class ExerciseDetailScreen extends StatelessWidget {
  final String name;
  final String equipment;
  final String instructions;

  const ExerciseDetailScreen({
    super.key,
    required this.name,
    required this.equipment,
    required this.instructions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Equipment: $equipment',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            const Text(
              'Instructions:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  instructions,
                  style: const TextStyle(fontSize: 16, height: 1.6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
