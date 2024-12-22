// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import '../../Services/auth_service.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  String selectedRole = "User"; // default selected role fro dropdown
  bool isLoading = false; // tp show loading spinner during signup waiting time
  bool isPasswordHidden = true;

  //instance for AuthService for authentication logic
  final AuthService _authService = AuthService();
  // signup function to handle user registration
  void _signup() async {
    setState(() {
      isLoading = true;
    });
    // call signup method from authservice with user inputes
    String? result = await _authService.signup(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
      role: selectedRole,
    );
    setState(() {
      isLoading = false;
    });
    if (result == null) {
      // signup successful : Navigate to loginscreen with success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
          "Signup Successful! Now Turn to Login",
        )),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
      );
    } else {
      // signup failed: show the error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
          "Signup Failed $result",
        )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.asset("assets/6333204.jpg"),
            const SizedBox(height: 20),
            // inpute for name,
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            // inpute for email,
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            // inpute for password
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: "Password",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isPasswordHidden = !isPasswordHidden;
                    });
                  },
                  icon: Icon(
                    isPasswordHidden ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
              obscureText: isPasswordHidden,
            ),
            const SizedBox(height: 15),

            // dropdown for selecting the role
            DropdownButtonFormField(
              value: selectedRole,
              decoration: const InputDecoration(
                labelText: "Role",
                border: OutlineInputBorder(),
              ),
              items: ["Admin", "User"].map((role) {
                return DropdownMenuItem(
                  value: role,
                  child: Text(role),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedRole =
                      newValue!; // update rolse selection in text field
                });
              },
            ),
            const SizedBox(height: 20),
            // signup button
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _signup,
                      child: const Text("Signup"),
                    ),
                  ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  "Already have an account? ",
                  style: TextStyle(fontSize: 18),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LoginScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Login here",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      letterSpacing: -1,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
