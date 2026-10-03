import 'package:nana/core/constants/profile_menu.dart';
import 'package:nana/core/constants/theme_color.dart';
import 'package:nana/core/routes/route.dart';
import 'package:nana/features/auth/bloc/auth_bloc.dart';
import 'package:nana/features/auth/bloc/auth_event.dart';
import 'package:nana/features/auth/bloc/auth_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLogout) {
          context.go(Routes.login);
        }

        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message ?? 'Something went wrong'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        ),

        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is AuthAuthenticated) {
              final user = state.user;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20),

                    Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 52,
                            backgroundColor: Color(0xFFF0EBFF),
                            backgroundImage: state.user?.photoURL != null
                                ? NetworkImage(state.user!.photoURL!)
                                : null,
                            child: user?.photoURL == null
                                ? Icon(
                                    Icons.person,
                                    size: 55,
                                    color: ThemeColor.primaryColor,
                                  )
                                : null,
                          ),

                          SizedBox(height: 12),

                          Text(
                            user?.displayName ?? 'User',
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 4),

                          Text(
                            user?.email ?? 'No email',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 30),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'My Account',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 10),

                    // cart list
                    profileMenu(
                      icon: Icons.favorite_border,
                      title: 'Wishlist',
                      subtitle: 'View your favorite products',
                      onTap: () {
                        context.push(Routes.cart);
                      },
                    ),

                    profileMenu(
                      icon: Icons.location_on_outlined,
                      title: 'Address',
                      subtitle: 'Manage your delivery address',
                      onTap: () {},
                    ),

                    profileMenu(
                      icon: Icons.shopping_bag_outlined,
                      title: 'My Orders',
                      subtitle: 'View your orders',
                      onTap: () {
                        // context.push(Routes.order);
                      },
                    ),

                    // Logout
                    profileMenu(
                      icon: Icons.logout,
                      title: 'Logout',
                      subtitle: 'Sign out from Nana',
                      iconColor: Colors.redAccent,
                      titleColor: Colors.redAccent,
                      onTap: () {
                        _showLogoutDialog(context);
                      },
                    ),

                    SizedBox(height: 30),
                  ],
                ),
              );
            }

            return Center(child: Text('Please login to view your profile'));
          },
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),

          title: Text('Logout', style: TextStyle(fontWeight: FontWeight.bold)),

          content: Text('Are you sure you want to logout?'),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: Text('Cancel'),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeColor.primaryColor,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(dialogContext);

                context.read<AuthBloc>().add(Logout());
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
