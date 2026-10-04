import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nana/core/constants/theme_color.dart';
import 'package:nana/core/routes/route.dart';
import 'package:nana/features/setting/screens/bloc/setting_bloc.dart';
import 'package:nana/features/setting/screens/bloc/setting_event.dart';
import 'package:nana/features/setting/screens/bloc/setting_state.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();

    context.read<SettingsBloc>().add(LoadSettings());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoading) {
            return Center(
              child: CircularProgressIndicator(color: ThemeColor.primaryColor),
            );
          }

          if (state is SettingsLoaded) {
            return ListView(
              padding: EdgeInsets.all(16),
              children: [
                Text(
                  'Preferences',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                  ),
                ),

                SizedBox(height: 10),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: SwitchListTile(
                    value: state.notificationsEnabled,
                    activeThumbColor: ThemeColor.primaryColor,
                    onChanged: (value) {
                      context.read<SettingsBloc>().add(
                        ToggleNotifications(value),
                      );
                    },
                    secondary: Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                        color: ThemeColor.primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.notifications_outlined,
                        color: ThemeColor.primaryColor,
                      ),
                    ),
                    title: Text(
                      'Notifications',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      state.notificationsEnabled
                          ? 'Notifications are enabled'
                          : 'Notifications are disabled',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 28),

                Text(
                  'About',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                  ),
                ),

                SizedBox(height: 10),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    leading: Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                        color: ThemeColor.primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.info_outline,
                        color: ThemeColor.primaryColor,
                      ),
                    ),
                    title: Text(
                      'About Nana',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: Icon(Icons.chevron_right, color: Colors.grey),
                    onTap: () {
                      context.push(Routes.aboutus);
                    },
                  ),
                ),
              ],
            );
          }

          return SizedBox();
        },
      ),
    );
  }
}
