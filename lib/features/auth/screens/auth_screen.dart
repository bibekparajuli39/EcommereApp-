import 'package:app_project/features/auth/screens/login_screen.dart';
import 'package:app_project/features/auth/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool showLogin = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(22),
                  child: Image.asset('assets/logo/logo.png', height: 100),
                ),

                Text(
                  showLogin ? 'Welcome Back!' : 'Create Account',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                Text(
                  showLogin
                      ? 'Login to continue'
                      : 'Create an account to get started',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),
                SizedBox(height: 10),
                Row(
                  spacing: 20,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: showLogin
                              ? Colors.white
                              : Colors.blue,
                        ),
                        onPressed: () {
                          setState(() {
                            showLogin = false;
                          });
                        },
                        child: Text(
                          'Signup',
                          style: TextStyle(
                            color: showLogin ? Colors.black : Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: showLogin
                              ? Colors.blue
                              : Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            showLogin = true;
                          });
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: showLogin ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                showLogin ? LoginScreen() : SignupScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
