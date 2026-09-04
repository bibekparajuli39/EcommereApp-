import 'package:app_project/routes/route.dart';
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
      body: Column(
        crossAxisAlignment: .start,
        spacing: 5,
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
                Row(
                  mainAxisAlignment: .center,
                  spacing: 10,
                  children: [
                    InkWell(
                      child: Text(
                        'Edit',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                    InkWell(
                      child: Text(
                        'Delete',
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ),
                  ],
                ),
                Text('Name'),
                Text('Email'),
              ],
            ),
          ),
          Spacer(),

          Padding(
            padding: EdgeInsetsGeometry.only(top: 40, left: 10),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  'My Orders',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                Container(
                  padding: EdgeInsets.only(right: 20),
                  height: 350,
                  child: ListView(
                    children: [
                      Card(
                        child: ListTile(
                          title: Text('Profile'),
                          subtitle: Text('Add/Edit/Delete'),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text('Wishlist'),
                          subtitle: Text('Add/Edit/Delete'),
                          onTap: () {
                            context.go(Routes.cart);
                          },
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text('Address'),
                          subtitle: Text('Add/Edit/Delete'),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text('Orders'),
                          subtitle: Text('Add/Edit/Delete'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
