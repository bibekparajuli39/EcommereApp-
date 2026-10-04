import 'package:flutter/material.dart';
import 'package:nana/core/constants/theme_color.dart';
import 'package:nana/core/widgets/aboutus_widgets/about_section.dart';
import 'package:nana/core/widgets/aboutus_widgets/info_row.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9FF),
      appBar: AppBar(
        title: Text(
          'About Nana',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: ThemeColor.primaryColor.withValues(alpha: 0.01),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                Icons.shopping_bag_rounded,
                size: 48,
                color: ThemeColor.primaryColor,
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'Nana',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 6),

            Text(
              'Discover. Shop. Enjoy.',
              style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
            ),

            const SizedBox(height: 28),

            buildSection(
              title: 'About Nana',
              child: Text(
                'Nana is a simple and convenient e-commerce '
                'application designed to make online shopping '
                'easy and enjoyable. Browse products, manage '
                'your cart, and enjoy a smooth shopping experience '
                'all in one place.',
                textAlign: .justify,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.6,
                  color: Colors.grey.shade700,
                ),
              ),
            ),

            const SizedBox(height: 18),

            buildSection(
              title: 'Features',
              child: Column(
                children: [
                  _featureItem(Icons.shopping_bag_outlined, 'Browse Products'),
                  _featureItem(Icons.shopping_cart_outlined, 'Shopping Cart'),
                  _featureItem(Icons.person_outline, 'User Profile'),
                  _featureItem(
                    Icons.notifications_none,
                    'Cart Reminder Notifications',
                  ),
                  _featureItem(Icons.payment_outlined, 'Khalti Payment'),
                  _featureItem(
                    Icons.login_outlined,
                    'Google,Facebook & Email Login',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            buildSection(
              title: 'Technology',
              child: Column(
                children: [
                  technologyItem('Flutter'),
                  technologyItem('Firebase & FireStore'),
                  technologyItem('BLoc'),
                  technologyItem('REST API'),
                  technologyItem('Khalti'),
                ],
              ),
            ),

            const SizedBox(height: 18),

            buildSection(
              title: 'App Information',
              child: Column(
                children: [
                  infoRow('Version', '1.0.0'),
                  infoRow('Platform', 'Flutter'),
                  infoRow('Developer', 'Bibek Parajuli'),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

Widget _featureItem(IconData icon, String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: ThemeColor.primaryColor.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: ThemeColor.primaryColor, size: 21),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}

Widget technologyItem(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(
      children: [
        Icon(Icons.check_circle, size: 20, color: ThemeColor.primaryColor),
        const SizedBox(width: 10),
        Text(title, style: const TextStyle(fontSize: 15)),
      ],
    ),
  );
}
