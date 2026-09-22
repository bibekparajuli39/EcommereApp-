import 'package:app_project/core/routes/route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkHpbyaPU2ALxd1HsLes7GoSOOPVRMyH8-BsNSgBThWQ&s=10',
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    'Name',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  Text('Email'),
                ],
              ),
            ),

            SizedBox(height: 30),

            // Menu section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                'My Account',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),

            SizedBox(height: 10),

            Card(
              elevation: 3,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('Profile'),
                subtitle: Text('Add/Edit/Delete'),
              ),
            ),

            Card(
              elevation: 3,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                leading: Icon(Icons.favorite),
                title: Text('Wishlist'),
                subtitle: Text('View your wishlist'),
                onTap: () {
                  context.go(Routes.cart);
                },
              ),
            ),

            Card(
              elevation: 3,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                leading: Icon(Icons.location_on),
                title: Text('Address'),
                subtitle: Text('Add/Edit/Delete'),
              ),
            ),

            Card(
              elevation: 3,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                leading: Icon(Icons.shopping_bag),
                title: Text('My Orders'),
                subtitle: Text('View your orders'),
              ),
            ),

            Card(
              elevation: 3,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                subtitle: Text('Manage your account'),
              ),
            ),

            Card(
              elevation: 3,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () {
                  // Logout
                },
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
