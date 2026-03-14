import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:gymfitness/auth/login_screen.dart';
import 'package:gymfitness/screens/privacy_policy_screen.dart';
import 'package:gymfitness/screens/terms_conditions_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDarkTheme = false;

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Are you sure to log out?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // cancel
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
            ),
            onPressed: () async {
              await Supabase.instance.client.auth.signOut();
              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              }
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String username =
        Supabase.instance.client.auth.currentUser?.email?.split('@')[0] ??
            'User';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 30),

          // Profile Picture and Username
          Center(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                      'assets/image3.jpg'), // provide image in assets
                ),
                const SizedBox(height: 12),
                Text(
                  username,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // Theme Toggle
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: const Text("Theme"),
            trailing: Switch(
              value: isDarkTheme,
              onChanged: (val) {
                setState(() {
                  isDarkTheme = val;
                  // Optionally: Apply theme changes here
                });
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text("Favourites"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()),
              );
            },
          ),
          // Privacy Policy
          const Divider(),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: const Text("Privacy Policy"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()),
              );
            },
          ),

          // Terms and Conditions
          const Divider(),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text("Terms & Conditions"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const TermsAndConditionsScreen()),
              );
            },
          ),

          // Logout
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: const Text(
              "Logout",
              style: TextStyle(color: Colors.redAccent),
            ),
            onTap: _showLogoutDialog,
          ),
        ],
      ),
    );
  }
}
