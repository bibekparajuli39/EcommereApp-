import 'package:app_project/core/routes/route.dart';
import 'package:app_project/features/auth/bloc/auth_bloc.dart';
import 'package:app_project/features/auth/bloc/auth_event.dart';
import 'package:app_project/features/auth/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return BlocListener(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          context.go(Routes.home);
        }
        if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message.toString())));
        }
      },
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: .start,
              mainAxisAlignment: .center,
              children: [
                Text('Username'),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                    hint: Text('Username'),

                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                SizedBox(height: 20),
                Text('Email'),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                    hint: Text('Email'),

                    prefixIcon: Icon(Icons.email),
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
                      context.go(Routes.login);
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                Row(
                  spacing: 10,
                  children: [
                    const Expanded(
                      child: Divider(color: Colors.grey, thickness: 1),
                    ),
                    const Text('Or'),
                    const Expanded(
                      child: Divider(color: Colors.grey, thickness: 1),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Center(
                  child: InkWell(
                    onTap: () {
                      context.read<AuthBloc>().add(GoogleLogin());
                    },
                    child: Column(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.google,
                          size: 40,
                          color: Colors.green,
                        ),
                        Text('Google'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
