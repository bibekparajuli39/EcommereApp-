import 'package:nana/core/constants/theme_color.dart';
import 'package:nana/features/ad/image_ad.dart';
import 'package:nana/features/auth/bloc/auth_bloc.dart';
import 'package:nana/features/auth/bloc/auth_state.dart';
import 'package:nana/features/product/screens/product_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const Color primaryColor = Color(0xFF6A3DE8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthAuthenticated) {
              return Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi, ${state.user!.displayName ?? "User"}!',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Discover products you'll love",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),

                  Spacer(),

                  CircleAvatar(
                    radius: 25,
                    backgroundImage: state.user?.photoURL != null
                        ? NetworkImage(state.user!.photoURL!)
                        : null,
                  ),
                ],
              );
            }
            return Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi,User!',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Discover products you'll love",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),

                Spacer(),

                CircleAvatar(radius: 25, child: Icon(Icons.person)),
              ],
            );
          },
        ),
      ),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,

        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.only(top: 15),
          child: Column(
            spacing: 20,
            crossAxisAlignment: .start,
            children: [
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: ThemeColor.primaryColor,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                    prefixIcon: IconButton(
                      color: ThemeColor.primaryColor,
                      onPressed: () {},
                      icon: Icon(Icons.search_sharp),
                    ),
                    hintText: 'Search anything',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF6A3DE8), Color(0xFF8B5CF6)],
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: .start,
                      spacing: 10,
                      children: [
                        Text(
                          'SUMMER COLLECTION',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                        ),
                        Text(
                          'New Arrivals \nAre Here',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            height: 1.1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: primaryColor,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            'Shop Now',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Expanded(child: ImageAd()),
                  ],
                ),
              ),

              ProductScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
