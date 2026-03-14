import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
        backgroundColor: Colors.redAccent,
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Text(
            '''
By downloading or using the Fitness Gym app, you agree to be bound by the following terms:

1. **Use of the App**  
This app is intended for personal use only. Do not misuse, copy, or reverse-engineer any part of the app.

2. **Account Responsibility**  
You are responsible for maintaining the confidentiality of your login credentials.

3. **Content & Services**  
We provide workout content, diet plans, and tracking features. Content is for general fitness guidance only and not a substitute for medical advice.

4. **Intellectual Property**  
All designs, images, logos, and text are the property of Fitness Gym App and cannot be reused without permission.

5. **Modifications to the Service**  
We reserve the right to update or remove features at any time without notice.

6. **Termination**  
Violation of these terms may result in suspension or termination of your account.

7. **Limitation of Liability**  
We are not responsible for any injury or damage resulting from the use of this app.

By continuing, you confirm that you have read, understood, and agree to these terms.

Contact support@gymfitnessapp.com for any concerns.
            ''',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
