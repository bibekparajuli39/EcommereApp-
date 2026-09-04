import 'package:app_project/routes/route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: .start,
          mainAxisAlignment: .center,
          children: [
            Center(
              child: Text(
                'Welcome to Login',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Text('Email'),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                hint: Text('Email or Username'),

                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 20),
            Text('Password'),
            TextFormField(
              obscureText: isVisible,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                hint: Text('*********'),
                prefixIcon: Icon(Icons.password),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  icon: isVisible
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(22),
                  ),
                  side: BorderSide.none,
                  minimumSize: const Size(200, 50),
                ),

                onPressed: () {
                  context.go(Routes.home);
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
