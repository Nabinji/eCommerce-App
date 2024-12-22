
import 'package:flutter/material.dart';

import '../Services/auth_service.dart';
import 'Role-based-login/login_screen.dart';
AuthService _authService = AuthService();

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: const Text("Profile Screen"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome User!'),
            ElevatedButton(
              onPressed: () {
                _authService.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginScreen(),
                  ),
                );
              },
              child: const Text("SignOut"),
            ),
          ],
        ),
      ),
    );
  }
}
// user user login then this screen is for logout
// we make it keep user login some time later.