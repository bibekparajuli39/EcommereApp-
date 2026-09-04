import 'package:app_project/features/cart/screens/cart_screen.dart';
import 'package:app_project/features/home/screen/home_screen.dart';

import 'package:app_project/features/profile/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int currentIndex = 0;
  List pages = [HomeScreen(), CartScreen(), ProfileScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (value) {
          currentIndex = value;
          setState(() {});
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),

          NavigationDestination(icon: Icon(Icons.shopping_bag), label: 'Cart'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      // BottomNavigationBar(
      //   currentIndex: currentIndex,
      //   items: [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      //     BottomNavigationBarItem(icon: Icon(Icons.arrow_back), label: 'Back'),
      //   ],
      // ),
    );
  }
}
