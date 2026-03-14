import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  SignupScreen({super.key});

  void signup(BuildContext context) async {
    try {
      final res = await Supabase.instance.client.auth.signUp(
        email: emailCtrl.text.trim(),
        password: passCtrl.text.trim(),
      );

      if (res.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Signup successful! Please check your email.')),
        );

        // Navigate to Login screen after successful signup
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/background.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(color: Colors.black.withOpacity(0.6)),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Signup',
                    style:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                TextField(
                  controller: emailCtrl,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    filled: true,
                    fillColor: Colors.white10,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: passCtrl,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    filled: true,
                    fillColor: Colors.white10,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => signup(context),
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
