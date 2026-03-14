import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'signup_screen.dart';
import 'package:gymfitness/screens/home_screen.dart'; // Make sure this exists

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();
  bool _isLoading = false;

  void login(BuildContext context) async {
    setState(() => _isLoading = true);

    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: emailCtrl.text.trim(),
        password: passCtrl.text.trim(),
      );

      if (response.user != null) {
        debugPrint("✅ Login success: ${response.user!.email}");

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful')),
        );

        // ✅ Use `pushAndRemoveUntil` to clear stack
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => HomeScreen()),
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid credentials')),
        );
      }
    } catch (error) {
      debugPrint("❌ Login error: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $error')),
      );
    } finally {
      setState(() => _isLoading = false);
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
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const Text('Login',
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
                  _isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () => login(context),
                          child: const Text('Login'),
                        ),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SignupScreen()),
                    ),
                    child: const Text("Don't have an account? Sign up"),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
