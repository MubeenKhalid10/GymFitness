import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://tlodxiuvjuetgugxeyni.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRsb2R4aXV2anVldGd1Z3hleW5pIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDk5OTkyMjgsImV4cCI6MjA2NTU3NTIyOH0.lih9sTFGzHng4On43r3q0-cU97t5HGMM1J9ncX86_Nc',
  );

  runApp(const FitnessGymApp());
}

class FitnessGymApp extends StatelessWidget {
  const FitnessGymApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const SplashScreen(),
    );
  }
}
