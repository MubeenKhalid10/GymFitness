import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Privacy Policy'),
          backgroundColor: Colors.redAccent),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Text(
            '''
We respect your privacy and are committed to protecting your personal data. 

This privacy policy explains how our Fitness Gym app collects, uses, and protects your information:

1. **Information Collection**  
We may collect your name, email address, and workout preferences to provide better services.  
We do **not** collect sensitive data without your consent.

2. **Usage of Information**  
Your data helps us personalize workouts, improve our services, and send important updates.  
We do **not** sell your personal information to third parties.

3. **Data Security**  
All your information is securely stored and transmitted using encryption.  
Access is restricted only to authorized personnel.

4. **Third-party Services**  
We may use trusted third-party APIs like Supabase and Wger. These services have their own privacy policies.

5. **User Control**  
You can access, update, or delete your account information at any time.  
Contact our support for any data-related inquiries.

By using this app, you agree to this privacy policy. We may update this policy from time to time.

For any questions, please email us at: support@gymfitnessapp.com
            ''',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
